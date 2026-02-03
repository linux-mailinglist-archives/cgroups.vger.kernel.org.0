Return-Path: <cgroups+bounces-13636-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDM3EPnXgWlYKgMAu9opvQ
	(envelope-from <cgroups+bounces-13636-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 12:11:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA93D8193
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 12:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9AF03083AFA
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507633122D;
	Tue,  3 Feb 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKWVu234"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E33030C
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117092; cv=none; b=H7M2jlUuJxNlkI8OvQ6bt4FRGvVwn6QACl1QEA1/7ui4wNvOGh+Rdb8qAimTo8Q5KOxShNXU/6ROWgBkGLE8VxeKMJ8E1e8Cw1O7GMzZCUfr2lAyYpfWY11xTevFL3sKKgebhiFiI7LuZTkbetPRhExa899K1XKnyIvPBZOdz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117092; c=relaxed/simple;
	bh=JDwzG10CjdMNzaVAVuClyAr1f5kyfccGkv+CaOIDDwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDM9dp9KFIOeTiGVQqavDy4vohCSAHk7Ina7E6Cvm7IhycMiPZ93QF159H3GNbDlPGKAmK4kHvEPDSTXsdogdoJbdF8FKffT6DdibOdMKshG8GDCCacZfHKgMNravpb4NaqdK03wLvE24Q9CV1hTQnuOp8DL8Bkuf7bi0SOf6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKWVu234; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770117089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIueVBBCXcriHzWqfI+eCbpC9/+UTkWA0vibOjUyafk=;
	b=YKWVu2348sP37G37JJ/A9SZV1QTyyJ+mXAU8+nqPN5+EASxNVLMjdGsmcaRuyvwT9Nqb8w
	NQaPKLWNG8+dIa+FNCkTrhlSqJwMpTlgFqpxg+qe7uM8+VEcuZFidHAGqqLS8lRP39Hs8r
	NLajXzuaU1PhaWV/ntrN4LsTCEGa2kA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-qQvQUZrJMKSyWnjugSNfKA-1; Tue,
 03 Feb 2026 06:11:25 -0500
X-MC-Unique: qQvQUZrJMKSyWnjugSNfKA-1
X-Mimecast-MFC-AGG-ID: qQvQUZrJMKSyWnjugSNfKA_1770117083
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F10FA1956046;
	Tue,  3 Feb 2026 11:11:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B5B61956053;
	Tue,  3 Feb 2026 11:11:16 +0000 (UTC)
Date: Tue, 3 Feb 2026 19:11:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <aYHXzyRJbzFSohNm@fedora>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,googlegroups.com,kernel.org,toxicpanda.com,kernel.dk,vger.kernel.org,fnnas.com];
	TAGGED_FROM(0.00)[bounces-13636-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ming.lei@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBA93D8193
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:54:34AM +0100, Michal Koutný wrote:
> Hello.
> 
> On Tue, Feb 03, 2026 at 11:03:01AM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> > Can you try the following patch?
> 
> I think it'd work thanks to the rcu_read_lock() in
> __blkcg_rstat_flush(). However, the chaining of RCU callbacks makes
> predictability of the release path less deterministic and may be
> unnecessary.

RCU supports this way, here is just 2-stage RCU chain, and everything
is deterministic.

> 
> What about this:
> 
> index 3cffb68ba5d87..e2f51e3bf04ef 100644
> --- a/tmp/b.c
> +++ b/tmp/a.c
> @@ -1081,6 +1081,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  		smp_mb();
>  
>  		WRITE_ONCE(bisc->lqueued, false);
> +		blkg_put(blkg);
>  		if (bisc == &blkg->iostat)
>  			goto propagate_up; /* propagate up to parent only */
>  
> @@ -2220,8 +2221,10 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	if (!READ_ONCE(bis->lqueued)) {
>  		struct llist_head *lhead = this_cpu_ptr(blkcg->lhead);
>  
> +		blkg_get(bio->bi_blkg);
>  		llist_add(&bis->lnode, lhead);
>  		WRITE_ONCE(bis->lqueued, true);
> +

I thought about this way, but ->lqueued is lockless, and in theory the `blkg_iostat_set`
can be added again after WRITE_ONCE(bisc->lqueued, false) happens, so this way looks
fragile.


Thanks, 
Ming


