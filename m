Return-Path: <cgroups+bounces-3921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093193D9D4
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 22:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E1F1F245F0
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E6149019;
	Fri, 26 Jul 2024 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsfvnhVF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFA146A8A
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026174; cv=none; b=NzIjV+PgHDQGT5O6A4S0ypIUU2DFSYTo59QrNlKUhW2gFaArFR3FbwKoitot/RveHpDAonQu3FbTSjKrTNOdcURzZ1+yB5NOCqT5DjSPgqOrgfGPKPle6kEdrYqGC3VnGJu//317B4L6DaUKbwFPJNN4n0JYiaw7lo1NER63aSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026174; c=relaxed/simple;
	bh=1yGabOCDYzM1SvBWjFVdPbv5wXNwEiSrRlUjdMYFRN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5ZE/bbT7qmflvNy0mIaKzQHITrEtQnhRFSOkpMfiFvpJgqeQ8olFmtH4981Sy+LPmp+RYdad2OYILo9kjTkcJJBilGLbBLe2RzQ5+i6/HvAuf9Xqg/cHz9CKhi8q5Vk8gsw3A2dmr9Vl6xU3icEGVZZtCgLpxVGMibq7BZbz7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsfvnhVF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722026171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm2UfiHnnlWhAZuLpVrEtIHN1JiWm1rRJEOIDoqpyDI=;
	b=AsfvnhVFJnchuF5WyXbXV4MW8N0fZFR/VB6SdZl6bNzvIGt4mtq7SKeiAxNlgWJgG17SFG
	My1/ikZ42nBC2NfNIsqtvpn951JX6+pfMzEL+F9mBBMKRkreP72T03u33a/TyOjl6FY5re
	gh4tUhAuloxOQqUgrIxvcGDMrNNI0mI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-v_DfzpV-PtmoRShQskjrvQ-1; Fri,
 26 Jul 2024 16:36:08 -0400
X-MC-Unique: v_DfzpV-PtmoRShQskjrvQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B467D1955D52;
	Fri, 26 Jul 2024 20:36:05 +0000 (UTC)
Received: from [10.2.16.80] (unknown [10.2.16.80])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B2EF1955D45;
	Fri, 26 Jul 2024 20:36:02 +0000 (UTC)
Message-ID: <463d8e53-0cac-419e-bd2a-584eb1c0725e@redhat.com>
Date: Fri, 26 Jul 2024 16:36:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240711025153.2356213-1-longman@redhat.com>
 <23hhazcy34yercbmsogrljvxatfmy6b7avtqrurcze3354defk@zpekfjpgyp6h>
 <0efbedff-3456-4e6a-8d2d-79b89a18864d@redhat.com>
 <qozzqah5blnsvc73jrhfuldsaxwsoluuewvgpukzgcuud4nqgc@xnctlkgk5yjv>
 <ZqQBaeAH_IfpRTnv@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZqQBaeAH_IfpRTnv@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 7/26/24 16:04, Tejun Heo wrote:
> Hello,
>
> On Fri, Jul 26, 2024 at 10:19:05AM +0200, Michal Koutný wrote:
>> On Thu, Jul 25, 2024 at 04:05:42PM GMT, Waiman Long <longman@redhat.com> wrote:
>>>> There's also 'debug' subsys. Have you looked at (extending) that wrt
>>>> dying csses troubleshooting?
>>>> It'd be good to document here why you decided against it.
>>> The config that I used for testing doesn't include CONFIG_CGROUP_DEBUG.
>> I mean if you enable CONFIG_CGROUP_DEBUG, there is 'debug' controller
>> that exposes files like debug.csses et al.
>>
>>> That is why "debug" doesn't show up in the sample outputs. The CSS #
>>> for the debug subsystem should show up if it is enabled.
>> So these "debugging" numbers could be implemented via debug subsys. So I
>> wondered why it's not done this way. That reasoning is missing in the
>> commit message.
> While this is a bit of implementation detail, it's also something which can
> be pretty relevant in production, so my preference is to show them in
> cgroup.stat. The recursive stats is something not particularly easy to
> collect from the debug controller proper anyway.
>
> One problem with debug subsys is that it's unclear whether they are safe to
> use and can be depended upon in production. Not that anything it shows
> currently is particularly risky but the contract around the debug controller
> is that it's debug stuff and developers may do silly things with it (e.g.
> doing high complexity iterations and what not).
>
> The debug controller, in general, I'm not sure how useful it is. It does
> nothing that drgn scripts can't do and doesn't really have enough extra
> benefits that make it better. We didn't have drgn back when it was added, so
> it's there for historical reasons, but I don't think it's a good idea to
> expand on it.

I totally agree.

For RHEL, CONFIG_CGROUP_DEBUG isn't enabled in the production kernel, 
but is enabled in the debug kernel. I believe it may be similar in other 
distros. So we can't really reliably depend on using the debug 
controller to get this information which can be useful to monitor cgroup 
behavior in a production kernel.

Cheers,
Longman


