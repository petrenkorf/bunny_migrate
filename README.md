# 🐰 BunnyMigrate

**Database-style migrations for RabbitMQ topology**

`bunny_migrate` lets you manage RabbitMQ **exchanges, queues, bindings, and policies** using **versioned migration files**, just like ActiveRecord migrations — but for messaging.

Instead of treating RabbitMQ topology as static configuration, BunnyMigrate treats it as **evolving infrastructure**.

---

## Why BunnyMigrate?

RabbitMQ gives you *many* ways to create topology:

* JSON definitions
* Operators / Helm charts
* Application auto-declaration
* Manual UI clicks (😬)

All of them describe **what the topology should look like now**.

None of them describe **how it safely evolved over time**.

That’s the gap BunnyMigrate fills.

### Problems it solves

* ❌ Accidental queue deletion with messages inside
* ❌ No audit trail of topology changes
* ❌ Risky refactors (routing keys, exchanges, queue splits)
* ❌ One-off scripts and tribal knowledge
* ❌ “Just don’t touch RabbitMQ in prod” fear

### What it gives you

* ✅ Ordered, versioned topology changes
* ✅ Safe, incremental evolution
* ✅ Reproducible environments
* ✅ Git-tracked history
* ✅ Familiar migration workflow

If you’ve ever wished RabbitMQ worked more like a database schema — this is for you.

---

## Core idea

Instead of one big snapshot:

```json
{
  "queues": [...],
  "exchanges": [...]
}
```

You write **migrations**:

```ruby
class AddOrdersExchange < BunnyMigrate::Migration
  def up
    exchange "orders", type: :topic, durable: true
  end

  def down
    delete_exchange "orders"
  end
end
```

Each migration is:

* Ordered
* Idempotent
* Explicit
* Reviewable

---

## Installation

Add to your Gemfile:

```ruby
gem "bunny_migrate"
```

Then:

```bash
bundle install
```

---

## Configuration

Create a config file (for example `config/bunny_migrate.yml`):

```yaml
rabbitmq:
  host: localhost
  port: 5672
  username: guest
  password: guest
  vhost: /
```

---

## Generating migrations

```bash
bundle exec bunny_migrate generate add_orders_exchange
```

This creates:

```
db/bunny_migrate/
  001_add_orders_exchange.rb
```

---

## Writing migrations

### Creating exchanges

```ruby
class AddOrdersExchange < BunnyMigrate::Migration
  def up
    exchange "orders", type: :topic, durable: true
  end

  def down
    delete_exchange "orders"
  end
end
```

---

### Creating queues and bindings

```ruby
class AddOrdersCreatedQueue < BunnyMigrate::Migration
  def up
    queue "orders.created", durable: true

    bind(
      exchange: "orders",
      queue: "orders.created",
      routing_key: "order.created"
    )
  end

  def down
    unbind(
      exchange: "orders",
      queue: "orders.created",
      routing_key: "order.created"
    )

    delete_queue "orders.created"
  end
end
```

---

### Safe refactors (real-world example)

Split one queue into two without losing messages:

```ruby
class SplitOrdersQueue < BunnyMigrate::Migration
  def up
    queue "orders.v2", durable: true

    bind exchange: "orders", queue: "orders.v2", routing_key: "order.*"
  end

  def down
    unbind exchange: "orders", queue: "orders.v2", routing_key: "order.*"
    delete_queue "orders.v2"
  end
end
```

Later migrations can:

* Drain old queues
* Unbind legacy consumers
* Delete only when safe

---

## Running migrations

Run all pending migrations:

```bash
bundle exec bunny_migrate up
```

Run a specific version:

```bash
bundle exec bunny_migrate up 012
```

Rollback:

```bash
bundle exec bunny_migrate down
```

Migration state is stored similarly to `schema_migrations`.

---

## How this differs from JSON definitions

| JSON Definitions  | BunnyMigrate       |
| ----------------- | ------------------ |
| Snapshot of state | History of change  |
| Risky deletes     | Explicit steps     |
| No ordering       | Ordered migrations |
| Hard to rollback  | Reversible logic   |
| Static            | Code + logic       |

JSON answers:

> “What should exist?”

Migrations answer:

> “How do we get there safely?”

---

## Kubernetes & GitOps

BunnyMigrate works **with**, not against:

* Kubernetes
* ArgoCD / Flux
* RabbitMQ Cluster Operator

Common pattern:

* Operator manages the cluster
* BunnyMigrate manages topology evolution

---

## When you should use BunnyMigrate

BunnyMigrate shines when:

* You have multiple services
* Topology changes over time
* Message loss is unacceptable
* You want auditability
* You already believe in migrations

If your RabbitMQ setup never changes, JSON is fine.
If it evolves — migrations win.

---

## Design principles

* No magic
* No hidden state
* No destructive defaults
* Explicit over implicit
* Messaging deserves the same rigor as data

---

## Contributing

PRs welcome — especially for:

* More migration helpers
* Safety checks
* Documentation
* Real-world examples

---

## Final note

> Databases taught us that schema changes are dangerous without discipline.
> Messaging is no different.

BunnyMigrate exists to bring that discipline to RabbitMQ.
