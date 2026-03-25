Return-Path: <cgroups+bounces-15035-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFEnGMJXw2k2qQQAu9opvQ
	(envelope-from <cgroups+bounces-15035-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 04:34:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4C731F289
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 04:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB649304020F
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 03:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808382949E0;
	Wed, 25 Mar 2026 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF3IUIig"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA7155C82
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774409597; cv=none; b=UJE2DKr/j7YblRZJYT0ixdMZIcTzvOK+y+pPR4NB38TFmgv0F2JSKiILHV4IQwA8pNSj8XT9PzkNNx+Dsxt89QgqQsho1+tly4ooKMzakr1u0vtG5EW8PCuSvj7sWxZfsB1I5xeClHovSeheD0ZQqRb0WMcZDyihKFu2ibP8EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774409597; c=relaxed/simple;
	bh=AnFNRlwct+JKKFysr9tCwmyAG+J8Rx9h6o3BWb5kgmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+daMdqT/jh94WkQfdjF8phh5xXiwI9mJxYn/LWQtPxIIirPanZrzZZsvMiZpwjMNDsgdyZPGAKYg+/81P/6PjjosakXeM7bZsPmBm8DVxPkRkd2Hv78v9k2w5H7uu5WOi51bu0aFerzcu2DOeFD/zYCoi5EhR/Mo3dIIevsEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RF3IUIig; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774409594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIqXsf7qQRyhZC/GxHM1lgBAlnhtV7VGCfnX70dQLZU=;
	b=RF3IUIigvQ2h2MyIoeaprMIDn12aHSDC1WzGF6eZ5JDrR51PWXwQ0osGBCZd+j3Hz5MTVh
	A+P67RIZ47AOK+tVXL7LJJqN7fDeePsLT/xfuZqusRW1gdmDrnnOgGqdne7Z1/qJfLRmYK
	3hfy53j37mFpSbfd9CgyiNiDns79I5g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-e4auf-kGMv-Z8m6w-sMMkw-1; Tue,
 24 Mar 2026 23:33:11 -0400
X-MC-Unique: e4auf-kGMv-Z8m6w-sMMkw-1
X-Mimecast-MFC-AGG-ID: e4auf-kGMv-Z8m6w-sMMkw_1774409588
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB67319560AA;
	Wed, 25 Mar 2026 03:33:07 +0000 (UTC)
Received: from [10.22.65.192] (unknown [10.22.65.192])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 343DA1800361;
	Wed, 25 Mar 2026 03:33:03 +0000 (UTC)
Message-ID: <201249f4-d07d-4baf-a77c-d77543a9cd55@redhat.com>
Date: Tue, 24 Mar 2026 23:33:03 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] selftests: memcg: Iterate pages based on the
 actual page size
To: Li Wang <liwang@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>,
 Sebastian Chlad <sebastianchlad@gmail.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-4-longman@redhat.com>
 <CAEemH2cJeTWLCLnmHqQY+tAs8b8FM+AmQ3UYd8McM760cN_Atw@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAEemH2cJeTWLCLnmHqQY+tAs8b8FM+AmQ3UYd8McM760cN_Atw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn];
	TAGGED_FROM(0.00)[bounces-15035-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC4C731F289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/22/26 10:53 PM, Li Wang wrote:
> Hi Waiman,
>
> I currently have another patch in hand that is functionally identical to
> patch 3/7 here (requested by Sashiko).
>
> May I go ahead and merge it directly into my patch series, while
> retaining your authorship attribution?

Sure. You can merge this patch into your series. I just need a page_size 
global variable to show the system page size for the rests of my 
memcontrol.c changes. I will then based my series on top of yours since 
it is further along.

Cheers,
Longman


