Return-Path: <cgroups+bounces-3655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DFC92FF3C
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 19:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569CAB2455B
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB6176FAB;
	Fri, 12 Jul 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipjuiIJP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABBE176AB1
	for <cgroups@vger.kernel.org>; Fri, 12 Jul 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804248; cv=none; b=Ia6sX3Il0oQLmuc1ndHiT3ejpjbeNwhUYsHSngja56TPI0XeMWvhFcFOLRtSL/57DrH81UTNc/Xz+cliibAW3UkZUlgjm4EkOSNY6BzsHkYwtUmhrwV4CbjqnG0Z2L7IdA/s2VdeQz4yo1UN+sp0cGLUV1FuWl25OP/msNbF3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804248; c=relaxed/simple;
	bh=QPbldaZLRVQw71mtTkMjBKj0haUUdISrLOQxYOJKFgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVPVTZC3YobEJ2MSd+1TFuFFsQsWamyXkMR1aUVESq7AWlsFqQLLShqpCq32G6mnhR8pcpw8mZ0H5H1D3fg9x9BDLWihaHrBsv5aFOS6sWQrx9sKyXDEB379A6CXJd4psK1YuxEPxrJyLvsXRNuftuIYOYW3ZQ+zFMP1KQHVBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipjuiIJP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720804246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnm3ivYBPn9ycwUjzHL/j+hS87OKKBuD3Bec1gFTGWo=;
	b=ipjuiIJPOsDJv1/zAIi1XKuYeRk4LC/JRPKjckRCwVHjk/QfZBdf5LNPfbpkPVdZZThNrs
	pfQ/hAKLbHE8BcSrZm5Ap65CL75A6XwWESksZzza8UO43P5wqsVCWHg9MDQ/ecyPiJ5vqE
	4DWpOj7mCGMaPE7SrxIyTYwU0w6XIYw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-oogQPAjpN5SBGdDFLTZiSA-1; Fri,
 12 Jul 2024 13:10:41 -0400
X-MC-Unique: oogQPAjpN5SBGdDFLTZiSA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E43AF195608B;
	Fri, 12 Jul 2024 17:10:38 +0000 (UTC)
Received: from [10.22.17.116] (unknown [10.22.17.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 259321955F40;
	Fri, 12 Jul 2024 17:10:36 +0000 (UTC)
Message-ID: <48802fec-0563-429b-95b2-571862ffff18@redhat.com>
Date: Fri, 12 Jul 2024 13:10:36 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
 <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
 <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>
 <ZpAoD7_o8bf6yVGr@slm.duckdns.org>
 <e5348a85-22eb-48a6-876d-3180de5c7171@redhat.com>
 <ZpArhD49OonR6Oz6@slm.duckdns.org>
 <c54651db-1a06-49f6-aea7-02768ad70756@redhat.com>
 <20240711195946.GA1094169@cmpxchg.org>
 <e42f41af-e8a9-4544-9194-003d6b0f0ba8@redhat.com>
 <20240712162920.GA1321673@cmpxchg.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240712162920.GA1321673@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/12/24 12:29, Johannes Weiner wrote:
> On Thu, Jul 11, 2024 at 05:00:41PM -0400, Waiman Long wrote:
>> On 7/11/24 15:59, Johannes Weiner wrote:
>>> On Thu, Jul 11, 2024 at 03:13:12PM -0400, Waiman Long wrote:
>>>> On 7/11/24 14:59, Tejun Heo wrote:
>>>>> On Thu, Jul 11, 2024 at 02:51:38PM -0400, Waiman Long wrote:
>>>>>> On 7/11/24 14:44, Tejun Heo wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On Thu, Jul 11, 2024 at 01:39:38PM -0400, Waiman Long wrote:
>>>>>>>> On 7/11/24 13:18, Tejun Heo wrote:
>>>>>>> ...
>>>>>>>> Currently, I use the for_each_css() macro for iteration. If you mean
>>>>>>>> displaying all the possible cgroup subsystems even if they are not enabled
>>>>>>>> for the current cgroup, I will have to manually do the iteration.
>>>>>>> Just wrapping it with for_each_subsys() should do, no? for_each_css() won't
>>>>>>> iterate anything if css doesn't exist for the cgroup.
>>>>>> OK, I wasn't sure if you were asking to list all the possible cgroup v2
>>>>>> cgroup subsystems even if they weren't enabled in the current cgroup.
>>>>>> Apparently, that is the case. I prefer it that way too.
>>>>> Yeah, I think listing all is better. If the list corresponded directly to
>>>>> cgroup.controllers, it may make sense to only show enabled ones but we can
>>>>> have dying ones and implicitly enabled memory and so on, so I think it'd be
>>>>> cleaner to just list them all.
>>>> That will means cgroup subsystems that are seldomly used like rdma, misc
>>>> or even hugetlb will always be shown in all the cgroup.stat output. I
>>>> actually prefer just showing those that are enabled. As for dying memory
>>>> cgroups, they will only be shown in its online ancestors. We currently
>>>> don't know how many level down are each of the dying ones.
>>> It seems odd to me to not show dead ones after a cgroup has disabled
>>> the controller again. They still consume memory, after all, and so
>>> continue to be property of that cgroup afterwards.
>>>
>>> Instead of doing for_each_css(), would it make more sense to have
>>>
>>> 	struct cgroup {
>>> 		...
>>> 		int nr_dying_subsys[CGROUP_SUBSYS_COUNT];
>> What exactly does new this array for?
> For keeping the counts. Instead of inside the css.
>
> AFAICS, with your current patch, if somebody were to disable the
> controller in cgroup.subtree_control, it would offline the css at that
> level, become unreachable from cgroup->subsys[], and you'd lose
> remaining counts of dead css that are still associated with that
> cgroup. Re-enabling the controller would create a new css with new
> descendant counts, and now the reported numbers are actively misleading.
>
> That seems undesirable.
>
> If you track the counts in the cgroup itself, then cgroup.stat would
> reliably show the total counts of dead controllers that are associated
> with the subtree, even after disabling or toggling controllers.
>
> The hooks in online, offline, release should be the same, just update
> css->cgroup->nr_dying_subsys[id] instead of css->nr_dying_descendants.

That does make sense. Thank for the suggestion. I will update the patch 
accordingly.

Cheers,
Longman


