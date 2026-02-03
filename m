Return-Path: <cgroups+bounces-13643-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPFmAiEKgmmCOQMAu9opvQ
	(envelope-from <cgroups+bounces-13643-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 15:45:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 527EDDAC4F
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 15:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64BE312D107
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6D3AA1B7;
	Tue,  3 Feb 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYLFvhpZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE103A1CFE
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129643; cv=none; b=RW1OeDJLrOTwZVY8hccfCK9dZF5ixc/+0TtMu/09Gfm/GrK6i3sRkfCycc003FNbh3X8H5j15FmZ6bfXIEehy53sc7g2ZTMyLP/2eosb8X4iJxZHjFHFZpsj8dNsXEi2X0/F0CrukjWFLF+sJPrRUDy8zinwOZYa0dBfQjOynQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129643; c=relaxed/simple;
	bh=gzADKnZnshWmlCett9WUmEgFJ73tJpuHtH0nAg1R+T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mca6m5UGmn/KOkb8Q1V+N1MVVS3TDKoPPMM0/GVNW32MORy1P3egnGKSy+s2WQVHRZoDnsvFttD5jrN17jRIeaRz89jlsUpj/1rXgT7Wyy44yrjz/u+qTC84PHxnZZtkZ4pxcGmvgeujaTLVvT2mq+hoKHbor4BA4V7ym4AgA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYLFvhpZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770129640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/nnbujEPK1lQRC/VY41UZ05KgAH7I2xmKiWW/7cFeI=;
	b=AYLFvhpZtpQZbWxuj+SNJxZE88MyYVwXFRSmFt+KiND2Lapz7xd5vW8s/lVUpV8nScJwyq
	r36eLUc7Cqdu0mnebY5H9NETGmeSnwMs1+5LILc+kilNIGJHuYFB/oVfpm6rIsgT1mbZzx
	rxEgTlBVsVjcepEplUAoDsso8ASv6uw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-puqqbEFcPZuegfmJDwGq1g-1; Tue,
 03 Feb 2026 09:40:37 -0500
X-MC-Unique: puqqbEFcPZuegfmJDwGq1g-1
X-Mimecast-MFC-AGG-ID: puqqbEFcPZuegfmJDwGq1g_1770129635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 590581800372;
	Tue,  3 Feb 2026 14:40:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 435A01800577;
	Tue,  3 Feb 2026 14:40:28 +0000 (UTC)
Date: Tue, 3 Feb 2026 22:40:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <aYII17gzXXPCTS3p@fedora>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
 <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
 <aYHXzyRJbzFSohNm@fedora>
 <l55sz3sgogoyniecolvzscjamxqrxlzgk7w7scds3tt42z6atj@nrfvjqg2agib>
 <aYIBR6eeudRUQ9q8@fedora>
 <74zggmy53vzdb2q7sidvasnnlih5d5b4rp6jb6ibpka5zg7z7x@enl7iqw4prji>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74zggmy53vzdb2q7sidvasnnlih5d5b4rp6jb6ibpka5zg7z7x@enl7iqw4prji>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-13643-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 527EDDAC4F
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:16:43PM +0100, Michal Koutný wrote:
> On Tue, Feb 03, 2026 at 10:08:07PM +0800, Ming Lei <ming.lei@redhat.com> wrote:
> > I can't parse your question, here blkg_release() simply needs to flush
> > all stats. Why do you talk about preventing new flush? why is it related
> > with this UAF?
> 
> What prevents this fix:
> 
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -169,14 +169,6 @@ static void __blkg_release(struct rcu_head *rcu)
>  #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
>         WARN_ON(!bio_list_empty(&blkg->async_bios));
>  #endif
> -       /*
> -        * Flush all the non-empty percpu lockless lists before releasing
> -        * us, given these stat belongs to us.
> -        *
> -        * blkg_stat_lock is for serializing blkg stat update
> -        */
> -       for_each_possible_cpu(cpu)
> -               __blkcg_rstat_flush(blkcg, cpu);
> 
>         /* release the blkcg and parent blkg refs this blkg has been holding */
>         css_put(&blkg->blkcg->css);
> @@ -195,6 +187,15 @@ static void blkg_release(struct percpu_ref *ref)
>  {
>         struct blkcg_gq *blkg = container_of(ref, struct blkcg_gq, refcnt);
> 
> +       /*
> +        * Flush all the non-empty percpu lockless lists before releasing
> +        * us, given these stat belongs to us.
> +        *
> +        * blkg_stat_lock is for serializing blkg stat update
> +        */
> +       for_each_possible_cpu(cpu)
> +               __blkcg_rstat_flush(blkcg, cpu);
> +
>         call_rcu(&blkg->rcu_head, __blkg_release);
>  }

This one looks more clever, can you send one formal patch?


Thanks, 
Ming


