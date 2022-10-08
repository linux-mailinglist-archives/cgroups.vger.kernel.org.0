Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B925F824F
	for <lists+cgroups@lfdr.de>; Sat,  8 Oct 2022 04:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJHCPo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Oct 2022 22:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJHCPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Oct 2022 22:15:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53263814D4;
        Fri,  7 Oct 2022 19:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665195340; x=1696731340;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=47u7X+WlCbz79fmnKKUMFHo3LBUWs88GcHrlh/Lb850=;
  b=fyaRyGwQe7Amz5BP2dlxb8PNHteUEuSdLLnc8NOocr9CqkgmfR2fO80H
   7vXKp4C153fQWpeCi72HB7FXmSCrzZmBlOaZeoetcKUAA3fu8bLBK3hun
   8BgKu+zv/OTOiJdPIqqNXhYzNh2WsAXDgddXurtJD1JguiYuAXXYFh4tR
   t4SIDdKPBhJDOAoURQskFtp/ZhT5hMbr0KdT6dx+bPXcbzhKxKWSc3ddH
   3iPnp4kAFNDM+65y9MDqopVMIy106FMU8vVqVOada4jxHY2/H2cQlcEFO
   uwGgsppvorm1jhniMHUnnl/ZKATW1vU7+jm+W1J6IgtSbzqQWS0ElLJWw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="305467890"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="305467890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 19:15:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="714476429"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="714476429"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 19:15:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7 1/3] llist: Add a lock-less list variant terminated
 by a sentinel node
References: <20221003154459.207538-1-longman@redhat.com>
        <20221003154459.207538-2-longman@redhat.com>
Date:   Sat, 08 Oct 2022 10:15:04 +0800
In-Reply-To: <20221003154459.207538-2-longman@redhat.com> (Waiman Long's
        message of "Mon, 3 Oct 2022 11:44:57 -0400")
Message-ID: <87sfjzuklz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> The lock-less list API is useful for dealing with list in a lock-less
> manner. However, one of the drawback of the current API is that there
> is not an easy way to determine if an entry has already been put into a
> lock-less list. This has to be tracked externally and the tracking will
> not be atomic unless some external synchronization logic is in place.
>
> This patch introduces a new variant of the lock-less list terminated
> by a sentinel node instead of by NULL. The function names start with
> "sllist" instead of "llist". The advantage of this scheme is that we
> can atomically determine if an entry has been put into a lock-less
> list by looking at the next pointer of the llist_node.

I guess that in the previous solution we use
test_and_set_bit()/clear_bit() on another member of the type containing
llist_node to track whether the node is in the llist?  After your patch,
we can use cmpxchg()/WRITE_ONCE(, NULL) on llist_node->next for that?

> Of course, the
> callers must clear the next pointer when an entry is removed from the
> lockless list. This is done automatically when the sllist_for_each_safe
> or sllist_for_each_entry_safe

Per my understanding, other xxx_for_each_safe() variants will not change
the list by itself.  So how about rename the functions?

> iteraters are used. The non-safe versions
> of sllist iterator are not provided.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/llist.h | 132 +++++++++++++++++++++++++++++++++++++++++-
>  lib/llist.c           |  79 ++++++++++++++++++++++++-
>  2 files changed, 209 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 85bda2d02d65..d9a921656adb 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -2,7 +2,8 @@
>  #ifndef LLIST_H
>  #define LLIST_H
>  /*
> - * Lock-less NULL terminated single linked list
> + * Lock-less NULL terminated singly linked list
> + * --------------------------------------------
>   *
>   * Cases where locking is not needed:
>   * If there are multiple producers and multiple consumers, llist_add can be
> @@ -46,6 +47,16 @@
>   *
>   * Copyright 2010,2011 Intel Corp.
>   *   Author: Huang Ying <ying.huang@intel.com>
> + *
> + * Lock-less sentinel node terminated singly linked list
> + * -----------------------------------------------------
> + *
> + * This is a variant of the generic lock-less list where the end of the list
> + * is terminated by a sentinel node instead of NULL. The advantage of this
> + * scheme is that we can use the next pointer of the llist_node to determine
> + * if it has been put into a lock-less list. However, the next pointer of
> + * the llist_node should be cleared ASAP after it has been removed from a
> + * lock-less list.
>   */
>  
>  #include <linux/atomic.h>
> @@ -64,6 +75,13 @@ struct llist_node {
>  #define LLIST_HEAD_INIT(name)	{ NULL }
>  #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
>  
> +/*
> + * Sentinel lock-less list
> + */
> +extern struct llist_node	__llist_end;
> +#define SLLIST_HEAD_INIT(name)	{ &__llist_end }
> +#define SLLIST_HEAD(name)	struct llist_head name = SLLIST_HEAD_INIT(name)
> +
>  /**
>   * init_llist_head - initialize lock-less list head
>   * @head:	the head for your lock-less list
> @@ -73,6 +91,15 @@ static inline void init_llist_head(struct llist_head *list)
>  	list->first = NULL;
>  }
>  
> +/**
> + * init_sllist_head - initialize sentinel lock-less list head
> + * @head:	the head for your sentinel lock-less list
> + */
> +static inline void init_sllist_head(struct llist_head *list)
> +{
> +	list->first = &__llist_end;
> +}
> +
>  /**
>   * llist_entry - get the struct of this entry
>   * @ptr:	the &struct llist_node pointer.
> @@ -99,6 +126,15 @@ static inline void init_llist_head(struct llist_head *list)
>  #define member_address_is_nonnull(ptr, member)	\
>  	((uintptr_t)(ptr) + offsetof(typeof(*(ptr)), member) != 0)
>  
> +/**
> + * member_address_is_notsentinel - check whether member address is not sentinel
> + * @ptr:	the object pointer (struct type * that contains the llist_node)
> + * @member:	the name of the llist_node within the struct.
> + */
> +#define member_address_is_notsentinel(ptr, member)	\
> +	((uintptr_t)(ptr) + offsetof(typeof(*(ptr)), member)	\
> +		!= (uintptr_t)&__llist_end)
> +
>  /**
>   * llist_for_each - iterate over some deleted entries of a lock-less list
>   * @pos:	the &struct llist_node to use as a loop cursor
> @@ -135,6 +171,18 @@ static inline void init_llist_head(struct llist_head *list)
>  #define llist_for_each_safe(pos, n, node)			\
>  	for ((pos) = (node); (pos) && ((n) = (pos)->next, true); (pos) = (n))
>  
> +/**
> + * sllist_for_each_safe - iterate over entries of a sentinel lock-less list
> + *			  safe against removal of list entry
> + * @pos:	the &struct llist_node to use as a loop cursor
> + * @n:		another &struct llist_node to use as temporary storage
> + * @node:	the first entry of deleted list entries
> + */
> +#define sllist_for_each_safe(pos, n, node)			\
> +	for ((pos) = (node); ((pos) !=  &__llist_end) &&	\
> +	     ((n) = (pos)->next,				\
> +	     ({ WRITE_ONCE((pos)->next, NULL); }), true); (pos) = (n))
> +
>  /**
>   * llist_for_each_entry - iterate over some deleted entries of lock-less list of given type
>   * @pos:	the type * to use as a loop cursor.
> @@ -178,6 +226,21 @@ static inline void init_llist_head(struct llist_head *list)
>  	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
>  	     pos = n)
>  
> +/**
> + * sllist_for_each_entry_safe - iterate over sentinel entries of lock-less list
> + *				of given type safe against removal of list entry
> + * @pos:	the type * to use as a loop cursor.
> + * @n:		another type * to use as temporary storage
> + * @node:	the first entry of deleted list entries.
> + * @member:	the name of the llist_node with the struct.
> + */
> +#define sllist_for_each_entry_safe(pos, n, node, member)		       \
> +	for (pos = llist_entry((node), typeof(*(pos)), member);		       \
> +	     member_address_is_notsentinel(pos, member) &&		       \
> +		(n = llist_entry((pos)->member.next, typeof(*(n)), member),    \
> +		({ WRITE_ONCE((pos)->member.next, NULL); }), true);	       \
> +	     pos = n)
> +
>  /**
>   * llist_empty - tests whether a lock-less list is empty
>   * @head:	the list to test
> @@ -191,15 +254,35 @@ static inline bool llist_empty(const struct llist_head *head)
>  	return READ_ONCE(head->first) == NULL;
>  }
>  
> +/**
> + * sllist_empty - tests whether a lock-less list is empty
> + * @head:	the list to test
> + */
> +static inline bool sllist_empty(const struct llist_head *head)
> +{
> +	return READ_ONCE(head->first) == &__llist_end;
> +}
> +
>  static inline struct llist_node *llist_next(struct llist_node *node)
>  {
>  	return node->next;
>  }
>  
> +static inline struct llist_node *sllist_next(struct llist_node *node)
> +{
> +	struct llist_node *next = node->next;
> +
> +	return (next == &__llist_end) ? NULL : next;
> +}
> +
>  extern bool llist_add_batch(struct llist_node *new_first,
>  			    struct llist_node *new_last,
>  			    struct llist_head *head);
>  
> +extern bool sllist_add_batch(struct llist_node *new_first,
> +			     struct llist_node *new_last,
> +			     struct llist_head *head);
> +
>  static inline bool __llist_add_batch(struct llist_node *new_first,
>  				     struct llist_node *new_last,
>  				     struct llist_head *head)
> @@ -209,6 +292,15 @@ static inline bool __llist_add_batch(struct llist_node *new_first,
>  	return new_last->next == NULL;
>  }
>  
> +static inline bool __sllist_add_batch(struct llist_node *new_first,
> +				      struct llist_node *new_last,
> +				      struct llist_head *head)
> +{
> +	new_last->next = head->first;
> +	head->first = new_first;
> +	return new_last->next == &__llist_end;
> +}
> +
>  /**
>   * llist_add - add a new entry
>   * @new:	new entry to be added
> @@ -221,11 +313,28 @@ static inline bool llist_add(struct llist_node *new, struct llist_head *head)
>  	return llist_add_batch(new, new, head);
>  }
>  
> +/**
> + * sllist_add - add a new entry
> + * @new:	new entry to be added
> + * @head:	the head for your lock-less list
> + *
> + * Returns true if the list was empty prior to adding this entry.
> + */
> +static inline bool sllist_add(struct llist_node *new, struct llist_head *head)
> +{
> +	return sllist_add_batch(new, new, head);
> +}
> +
>  static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
>  {
>  	return __llist_add_batch(new, new, head);
>  }
>  
> +static inline bool __sllist_add(struct llist_node *new, struct llist_head *head)
> +{
> +	return __sllist_add_batch(new, new, head);
> +}
> +
>  /**
>   * llist_del_all - delete all entries from lock-less list
>   * @head:	the head of lock-less list to delete all entries
> @@ -239,6 +348,17 @@ static inline struct llist_node *llist_del_all(struct llist_head *head)
>  	return xchg(&head->first, NULL);
>  }
>  
> +/**
> + * sllist_del_all - delete all entries from sentinel lock-less list
> + * @head:	the head of lock-less list to delete all entries
> + */
> +static inline struct llist_node *sllist_del_all(struct llist_head *head)
> +{
> +	struct llist_node *first = xchg(&head->first, &__llist_end);
> +
> +	return (first == &__llist_end) ? NULL : first;
> +}
> +
>  static inline struct llist_node *__llist_del_all(struct llist_head *head)
>  {
>  	struct llist_node *first = head->first;
> @@ -247,8 +367,18 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
>  	return first;
>  }
>  
> +static inline struct llist_node *__sllist_del_all(struct llist_head *head)
> +{
> +	struct llist_node *first = head->first;
> +
> +	head->first = &__llist_end;
> +	return (first == &__llist_end) ? NULL : first;
> +}
> +
>  extern struct llist_node *llist_del_first(struct llist_head *head);
> +extern struct llist_node *sllist_del_first(struct llist_head *head);
>  
>  struct llist_node *llist_reverse_order(struct llist_node *head);
> +struct llist_node *sllist_reverse_order(struct llist_node *head);
>  
>  #endif /* LLIST_H */
> diff --git a/lib/llist.c b/lib/llist.c
> index 611ce4881a87..418327394735 100644
> --- a/lib/llist.c
> +++ b/lib/llist.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Lock-less NULL terminated single linked list
> + * Lock-less NULL and sentinel node terminated singly linked lists
>   *
>   * The basic atomic operation of this list is cmpxchg on long.  On
>   * architectures that don't have NMI-safe cmpxchg implementation, the
> @@ -12,8 +12,11 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> +#include <linux/cache.h>
>  #include <linux/llist.h>
>  
> +struct llist_node __llist_end __ro_after_init;
> +EXPORT_SYMBOL_GPL(__llist_end);
>  
>  /**
>   * llist_add_batch - add several linked entries in batch
> @@ -36,6 +39,27 @@ bool llist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
>  }
>  EXPORT_SYMBOL_GPL(llist_add_batch);
>  
> +/**
> + * sllist_add_batch - add several linked entries in batch
> + * @new_first:	first entry in batch to be added
> + * @new_last:	last entry in batch to be added
> + * @head:	the head for your lock-less list
> + *
> + * Return whether list is empty before adding.
> + */
> +bool sllist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
> +		      struct llist_head *head)
> +{
> +	struct llist_node *first;
> +
> +	do {
> +		new_last->next = first = READ_ONCE(head->first);

Here new_last->next may be changed from NULL to non-NULL?  Do we need
to do this atomically?  Even cmpxchg() to guarantee it is NULL before
put into list?

> +	} while (cmpxchg(&head->first, first, new_first) != first);
> +
> +	return first == &__llist_end;
> +}
> +EXPORT_SYMBOL_GPL(sllist_add_batch);
> +
>  /**
>   * llist_del_first - delete the first entry of lock-less list
>   * @head:	the head for your lock-less list
> @@ -69,6 +93,33 @@ struct llist_node *llist_del_first(struct llist_head *head)
>  }
>  EXPORT_SYMBOL_GPL(llist_del_first);
>  
> +/**
> + * sllist_del_first - delete the first entry of sentinel lock-less list
> + * @head:	the head for your lock-less list
> + *
> + * If list is empty, return NULL, otherwise, return the first entry
> + * deleted, this is the newest added one.
> + */
> +struct llist_node *sllist_del_first(struct llist_head *head)
> +{
> +	struct llist_node *entry, *old_entry, *next;
> +
> +	entry = smp_load_acquire(&head->first);
> +	for (;;) {
> +		if (entry == &__llist_end)
> +			return NULL;
> +		old_entry = entry;
> +		next = READ_ONCE(entry->next);
> +		entry = cmpxchg(&head->first, old_entry, next);
> +		if (entry == old_entry)
> +			break;
> +	}
> +	WRITE_ONCE(entry->next, NULL);
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL_GPL(sllist_del_first);
> +
>  /**
>   * llist_reverse_order - reverse order of a llist chain
>   * @head:	first item of the list to be reversed
> @@ -90,3 +141,29 @@ struct llist_node *llist_reverse_order(struct llist_node *head)
>  	return new_head;
>  }
>  EXPORT_SYMBOL_GPL(llist_reverse_order);
> +
> +/**
> + * sllist_reverse_order - reverse order of a llist chain
> + * @head:	first item of the list to be reversed
> + *
> + * Reverse the order of a chain of llist entries and return the
> + * new first entry.
> + */
> +struct llist_node *sllist_reverse_order(struct llist_node *head)
> +{
> +	struct llist_node *new_head = &__llist_end;
> +
> +	if (!head || (head == &__llist_end))
> +		return NULL;
> +
> +	while (head != &__llist_end) {
> +		struct llist_node *tmp = head;
> +
> +		head = head->next;
> +		tmp->next = new_head;
> +		new_head = tmp;
> +	}
> +
> +	return new_head;
> +}
> +EXPORT_SYMBOL_GPL(sllist_reverse_order);

Best Regards,
Huang, Ying
