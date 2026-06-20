Return-Path: <cgroups+bounces-17097-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lKhXFF7cNmq4FgcAu9opvQ
	(envelope-from <cgroups+bounces-17097-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:30:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE26A9793
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:30:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.s=s1 header.b=Iv+YCi1O;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17097-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17097-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E2713011BE0
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCAA21257E;
	Sat, 20 Jun 2026 18:30:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from sg-3-43.ptr.tlmpb.com (sg-3-43.ptr.tlmpb.com [101.45.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9740D57C
	for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 18:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781980251; cv=none; b=qTvv+5eXKR3HSw8yH67n/cjl9aY+vFBZJOqRuAHqPLfEr6iYkOMDkCTZZarfWRva3GppXogeeipUDLKgspFz3zmO3kOmPN++znik8X2OzTDldWIffebOF1HRaNHOBu6F+rRhlZLGv87E9z2Swv5HGH3UjZE6Rzkeq6Z8Vu7zjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781980251; c=relaxed/simple;
	bh=G1uhWbOWHiqNXfGifFXXcw8ke982MTwaX1MAkHhH0XA=;
	h=To:Message-Id:In-Reply-To:Subject:Date:References:Content-Type:Cc:
	 From:Mime-Version; b=SnAI7e6WaaftGjPZBph7HdNRD+yCvx16kRtgBKFmskLguqs5txdSrbCwgZK0lSjCQ0TL8T5Zan38REA6XSiQk3QMLHFw9G7uR0CSroCHRHIJiJ5iMLOl/VVJdwrUvnzcOM/ltw2aR31tnKwaSjK1MUtCGrUis24+qBE7F/yRSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=Iv+YCi1O; arc=none smtp.client-ip=101.45.255.43
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1781980157;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=EGlr82o2GSnKsx/C994OUQb0Z+hiBArYu2jTenNVYCg=;
 b=Iv+YCi1OhOmQGa6UJFy8FB9DNppNMeJRr0uVmaTiLnXsX9KDrhhQbf7qs6SF/LuDNEnDdB
 Et9mvp0maa+WPaAQNmXH+O+0nm412XL9BbAeBgzUak8yi6FbakzMhiox/RlCWbUSvT2rY+
 POLJXd5SvnxFmfHYC70+x/t2B/vWKPilA5Lp5iGaj1nOe08gc4In7qp8HbDcRloOUYC0PY
 lJavnxmsa9pey028eGSAxYuCuG5ehy60Qs4j8l7/ZqQlbZ0YWjMdG1FTYy+6+pqWrZHjhD
 1dcQg+qe38Ovan6FVzz03SKnfPttHyJqrCnxzCMWehtGBBDE4zhBTQNZxMuX7A==
X-Lms-Return-Path: <lba+26a36dbfc+97cde0+vger.kernel.org+yukuai@fygo.io>
To: "Zizhi Wo" <wozizhi@huaweicloud.com>, <axboe@kernel.dk>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <linux-block@vger.kernel.org>
Message-Id: <e8758537-a13f-4e65-b407-6c73c5b593e5@fygo.io>
In-Reply-To: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: yu kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] blk-cgroup: defer blkcg css_put until blkg is unlinked from queue
Date: Sun, 21 Jun 2026 02:29:11 +0800
References: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Received: from [192.168.1.104] ([39.182.0.148]) by smtp.larksuite.com with ESMTPS; Sat, 20 Jun 2026 18:29:15 +0000
Content-Type: text/plain; charset=UTF-8
Reply-To: yukuai@fygo.io
Cc: <cgroups@vger.kernel.org>, <yangerkun@huawei.com>, 
	<chengzhihao1@huawei.com>, <houtao1@huawei.com>, <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fygo-io.20200929.dkim.larksuite.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17097-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wozizhi@huaweicloud.com,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:houtao1@huawei.com,m:yukuai@fygo.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fygo-io.20200929.dkim.larksuite.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[yukuai@fygo.io];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fygo-io.20200929.dkim.larksuite.com:dkim,vger.kernel.org:from_smtp,fygo.io:replyto,fygo.io:email,fygo.io:mid,fygo.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79CE26A9793

=E5=9C=A8 2026/6/16 9:17, Zizhi Wo =E5=86=99=E9=81=93:

> From: Zizhi Wo<wozizhi@huawei.com>
>
> [BUG]
> Our fuzz testing triggered a blkcg use-after-free issue:
>
>    BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>    Call Trace:
>    ...
>    blkcg_deactivate_policy+0x244/0x4d0
>    ioc_rqos_exit+0x44/0xe0
>    rq_qos_exit+0xba/0x120
>    __del_gendisk+0x50b/0x800
>    del_gendisk+0xff/0x190
>    ...
>
> [CAUSE]
> process1						process2
> cgroup_rmdir
> ...
>    css_killed_work_fn
>      offline_css
>      ...
>        blkcg_destroy_blkgs
>        ...
>          __blkg_release
> 	  css_put(&blkg->blkcg->css)
>            blkg_free
> 	    INIT_WORK(xxx, blkg_free_workfn)
> 	    schedule_work
>      css_put
>      ...
>        blkcg_css_free
>          kfree(blkcg)--------blkcg has been freed!!!
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dschedule_work
>                blkg_free_workfn
> 							__del_gendisk
> 							  rq_qos_exit
> 							    ioc_rqos_exit
> 							      blkcg_deactivate_policy
> 							        mutex_lock(&q->blkcg_mutex)
> 								spin_lock_irq(&q->queue_lock)
> 							        list_for_each_entry(blkg, xxx)
> 								  blkcg =3D blkg->blkcg
> 								  spin_lock(&blkcg->lock)-------UAF!!!
> 	        mutex_lock(&q->blkcg_mutex)
> 	        spin_lock_irq(&q->queue_lock)
> 	        /* Only then is the blkg removed from the list */
> 	        list_del_init(&blkg->q_node)
>
> As a result, a blkg can still be reachable through q->blkg_list while
> its ->blkcg has already been freed.
>
> [Fix]
> Fix this by deferring the blkcg css_put() until after the blkg has been
> unlinked from q->blkg_list in blkg_free_workfn(). This ensures that the
> blkcg outlives every blkg still reachable through q->blkg_list, so any
> iterator holding q->queue_lock is guaranteed to observe a valid
> blkg->blkcg.
>
> While at it, move css_tryget_online() from blkg_create() into blkg_alloc(=
)
> so that the css reference is owned by the alloc/free pair rather than
> straddling layers:
> blkg_alloc()  <-> blkg_free()
> blkg_create() <-> blkg_destroy()
>
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Suggested-by: Hou Tao<houtao1@huawei.com>
> Signed-off-by: Zizhi Wo<wozizhi@huawei.com>
> Reviewed-by: Yu Kuai<yukuai@fygo.io>
> ---
> v3:
>   - move css_put() after mutex_unlock() in blkg_free_workfn().
>
> v2:
>   - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
>     css reference follows the blkg's own lifetime, making the put in
>     blkg_free_workfn() symmetric with the get in blkg_alloc().
>
> v1:https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweiclou=
d.com/
>   block/blk-cgroup.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai

