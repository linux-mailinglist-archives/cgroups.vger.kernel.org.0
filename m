Return-Path: <cgroups+bounces-3572-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB192A984
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 21:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428E41F224B3
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C514B967;
	Mon,  8 Jul 2024 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="II4bTgle"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE114E2E3
	for <cgroups@vger.kernel.org>; Mon,  8 Jul 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465314; cv=none; b=E/VdPBU9Zn8wuHU0XfOyF94F59xY1X1ILtq3Ft69iwZys4tLPvceiL8o0a5GomM6TnHEUQ6o/U13bzSqbGv12N5BCXFKRhsdgCiKUc/5Ra71v4Vehfy4KCWKbdSV8R42fQabqHyhwt+Aa9v3pynXwyEoT3P7hh3uTROEyNAnXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465314; c=relaxed/simple;
	bh=jP2M0JpMs2wAYT7RmW+K09ipvg9NM/5VSFNHQgyu+uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+cfmreoQhoo869rYYDMJD65f0RJFqn4vNSzUjakG58RaALP736YFxV2QthbLuRym68FfwlYeG+l/3yJJvuSpbz2HS94mJeeL8Q2KxfV5SolH9LnJBe8NLnktkPEBlCKyEboLmdmoSoCLgjYaxH9RDfOJyFatkunTE9NIc5AHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=II4bTgle; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720465312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLGoCNz9DClhgM4ZV9QmfktXdqX3rAlfMW12nS2PwS8=;
	b=II4bTgleiQvzO7joiNc/vxykAR0aURCOeQkgxquDJmXdrxdxTC2fOj/stBTa5hsXbb4X55
	qNMVH21qQ0Ld5nfM4A6uc+jf1wDT/FFkZvnajwZTwSgVTxlr3VEgG9+emCJ8Wh2bVyV9Cn
	SSfNFKN0404bW+6t9/myrH1PWyPmQ3w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-HdacGquzPCOi2M7P_MpIWw-1; Mon,
 08 Jul 2024 15:01:44 -0400
X-MC-Unique: HdacGquzPCOi2M7P_MpIWw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6E1519560B0;
	Mon,  8 Jul 2024 19:01:41 +0000 (UTC)
Received: from [10.22.33.83] (unknown [10.22.33.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57C253000181;
	Mon,  8 Jul 2024 19:01:40 +0000 (UTC)
Message-ID: <b505c15b-8fd2-44f2-8e33-46ae29c2696e@redhat.com>
Date: Mon, 8 Jul 2024 15:01:39 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 1/2] cgroup: Show # of subsystem CSSes in
 /proc/cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240706005622.2003606-1-longman@redhat.com>
 <Zowzvf2NEOzgXYr3@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zowzvf2NEOzgXYr3@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 7/8/24 14:45, Tejun Heo wrote:
> Hello, Waiman.
>
> On Fri, Jul 05, 2024 at 08:56:21PM -0400, Waiman Long wrote:
>> The /proc/cgroups file shows the number of cgroups for each of the
>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>> number of cgroups. That is not the case anymore with cgroup v2. The
>> /proc/cgroups file cannot show the actual number of CSSes for the
>> subsystems that are bound to cgroup v2.
>>
>> So if a v2 cgroup subsystem is leaking cgroups (typically memory
>> cgroup), we can't tell by looking at /proc/cgroups which cgroup
>> subsystems may be responsible.  This patch adds a css counter in the
>> cgroup_subsys structure to keep track of the number of CSSes for each
>> of the cgroup subsystems.
> The count sounds useful to me but can we add it in cgroup.stats instead?

That information is certainly useful to display to cgroup.stat which 
currently only shows nr_descendants and nr_dying_descendants. So does 
"nr_<subsys_name> <cnt>" for each cgroup subsystems look good to you or 
do you have other suggestion?

The reason for this patch is because I got a bug report about leaking 
blkio cgroup due to the information shown in /proc/cgroups. I know you 
want do deprecate it for cgroup v2. How about adding a iine like "# 
Deprecated for cgroup v2, use cgroup.stats file for cgroup counts" at 
the top of /proc/cgroups when cgroup v2 is active?

Cheers,
Longman



