Return-Path: <cgroups+bounces-7543-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436D7A89066
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3FE17CCB5
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37B21348;
	Tue, 15 Apr 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANLISXgw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FC1CA81;
	Tue, 15 Apr 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744676378; cv=none; b=j5sz7Encri4lQZPq69D6omZ/NI414Et4PIRVzMehv/i44aMLNxXRsdoiNWG4BrlJcqCzPSQ45eeic6eukj6uLU/WXUJjn4fDN+nNrixupp2kLV7B86Cuhj7pK9F4NeljCc2rzF+BiBPmtfYkLwZEmc7cchK/ZNXDw342gNaNSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744676378; c=relaxed/simple;
	bh=SOAAWgOv5lC97vDbfrXHcPgGTUP7cEcIHA2HIYurhQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A40NM4NQcQ03wdHMRwyJ7NWufNgw9gLB9aTP0e12NelvdysaqnzKgttweSQg9dVYYFuLKb1yAhFJCHBENja2LvLWozJ6SKdpHKvR6zhqvvDnQfbMrVTaYUxhpVQJUqKpDGfa33HdhQjg1LzPk006gIFEn2mVH+0oojmMxeDrWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANLISXgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0275C4CEE2;
	Tue, 15 Apr 2025 00:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744676378;
	bh=SOAAWgOv5lC97vDbfrXHcPgGTUP7cEcIHA2HIYurhQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANLISXgwtSCcglkO1DGE7VKYyD/kC4KRqt7dvBx1Yivn2k285++cNRUpHk/9bYQEo
	 kdky2T4TuD/24l+ZjLDU4+Ghvol6o4DsoFrW7KOFXPV2prGA+IMLWyEPxePFkaOMin
	 c0dUC/r6Yw+f8iRRSj13aTLiwDw3XEAMR5SycLzg90/PNpRmTQVu7b+p2/145vGXyc
	 dHJ7YdTCzuvkhHG/lBnTAkpyRt3mSuusv8j18rXd4+xzEh9momDLH9Gjps+KsTTQy7
	 7C/CBNnAOF2XtUkpzLolBtAX8ssapdpoKblfg3CkGSgUBPrDwoawQaY1aa93qMEsft
	 yh1lQN7V+MiDg==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: Re: [RFC PATCH v4 4/6] migrate: implement migrate_misplaced_folio_batch
Date: Mon, 14 Apr 2025 17:19:35 -0700
Message-Id: <20250415001935.120888-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250411221111.493193-5-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 18:11:09 -0400 Gregory Price <gourry@gourry.net> wrote:

> A common operation in tiering is to migrate multiple pages at once.
> The migrate_misplaced_folio function requires one call for each
> individual folio.  Expose a batch-variant of the same call for use
> when doing batch migrations.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  include/linux/migrate.h |  6 ++++++
>  mm/migrate.c            | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 61899ec7a9a3..2df756128316 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -145,6 +145,7 @@ const struct movable_operations *page_movable_ops(struct page *page)
>  int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node);
>  int migrate_misplaced_folio(struct folio *folio, int node);
> +int migrate_misplaced_folio_batch(struct list_head *foliolist, int node);

Nit.  s/foliolist/folio_list/ ?

The none-inline-definition of the function below calls the parameter
folio_list, and I show more treewide usage of folio_list than foliolist.

    linux$ git grep foliolist | wc -l
    4
    linux$ git grep folio_list | wc -l
    142

I wouldn't argue folio_list is the only one right name, but at least using same
name on the declaration and the definition[s] would be nice in terms of
consistency.

>  #else
>  static inline int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node)
> @@ -155,6 +156,11 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>  {
>  	return -EAGAIN; /* can't migrate now */
>  }
> +static inline int migrate_misplaced_folio_batch(struct list_head *foliolist,

Ditto.

> +						int node)
> +{
> +	return -EAGAIN; /* can't migrate now */
> +}
>  #endif /* CONFIG_NUMA_BALANCING */
>  
>  #ifdef CONFIG_MIGRATION
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 047131f6c839..7e1ba6001596 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2731,5 +2731,36 @@ int migrate_misplaced_folio(struct folio *folio, int node)
>  	BUG_ON(!list_empty(&migratepages));
>  	return nr_remaining ? -EAGAIN : 0;
>  }
> +
> +/*
> + * Batch variant of migrate_misplaced_folio. Attempts to migrate
> + * a folio list to the specified destination.
> + *
> + * Caller is expected to have isolated the folios by calling
> + * migrate_misplaced_folio_prepare(), which will result in an
> + * elevated reference count on the folio.
> + *
> + * This function will un-isolate the folios, dereference them, and
> + * remove them from the list before returning.
> + */
> +int migrate_misplaced_folio_batch(struct list_head *folio_list, int node)
> +{
> +	pg_data_t *pgdat = NODE_DATA(node);
> +	unsigned int nr_succeeded;
> +	int nr_remaining;
> +
> +	nr_remaining = migrate_pages(folio_list, alloc_misplaced_dst_folio,
> +				     NULL, node, MIGRATE_ASYNC,
> +				     MR_NUMA_MISPLACED, &nr_succeeded);
> +	if (nr_remaining)
> +		putback_movable_pages(folio_list);
> +
> +	if (nr_succeeded) {
> +		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);

migrate_misplaced_folio() also counts memcg events and call mod_lruvec_state(),
but this variant doesn't.  Is this an intended difference?  If so, could you
please clarify the reason?

> +		mod_node_page_state(pgdat, PGPROMOTE_SUCCESS, nr_succeeded);
> +	}
> +	BUG_ON(!list_empty(folio_list));
> +	return nr_remaining ? -EAGAIN : 0;
> +}

I feel some code here is duplicated from a part of migrate_misplaced_folio().
Can we deduplicate those?  Maybe migrate_misplaced_folio() could be a wrapper
of migrate_mispalced_folio_batch()?


Thanks,
SJ

[...]

