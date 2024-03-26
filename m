Return-Path: <cgroups+bounces-2168-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F5B88C696
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 16:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50B8B214CD
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F3213C80C;
	Tue, 26 Mar 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7lvI/vb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD6763E2
	for <cgroups@vger.kernel.org>; Tue, 26 Mar 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466104; cv=none; b=pM7YWJbibPr2pnCgyCZ8W48grouo8+v6+fC3rV6vDU4Q0l3wUzi9We9OE1bWEPqqgPfK/1ErsLqa4sTrlbBFV9whvBsfvcFFskqhaIHHevgyoskg9OufGZZk1qjKtDrpN3BwWxfE+QOdk0CjGlccDn4OQXf+N39jif5oXekoyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466104; c=relaxed/simple;
	bh=rZUlhrZrFOEBgDmHKnu8B897vERZc+NHJZOltpFZZfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTvnlTBioJ7KwlYv77LHowfUWmH2gS0aIKesg6YZzcHj/6j699s2dy0CrJHwB0BspEJAhBRed/5biJJFpIFYfMc2GnYHf6YRIpqOsZ3sSQv+Q8oD6VdAtzVxVkEX2778+mCRA2DNpmtHsvkOZmgtm8clNIEPsc+CUSfhFjszofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7lvI/vb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711466102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2Wyjhd+3dp1rjt02EAGYMoL+qRXMXYRAHy1Q/7L4Lw=;
	b=P7lvI/vbewiAH0X7dNQ6tQF5czDcBb45ZAngr50ZeYnx/Mvp2AvUOWIYiW5t2TxuRluWau
	FgSBhk7LE9arbf60aG0LBkJADKeVD4wB6pVaSSXP/LPK+paUqMEsT88issYVeGRoWPRy23
	0h1E9SmJDYB4+YyqAAvD2I1Wg9eCpko=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-g0DmJSBYMRS5I6vEJF-olA-1; Tue,
 26 Mar 2024 11:14:58 -0400
X-MC-Unique: g0DmJSBYMRS5I6vEJF-olA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D26F21C01B32;
	Tue, 26 Mar 2024 15:14:57 +0000 (UTC)
Received: from [10.22.18.245] (unknown [10.22.18.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A10A1C060D6;
	Tue, 26 Mar 2024 15:14:57 +0000 (UTC)
Message-ID: <c700ec0d-9260-438f-a9c8-7d7c268e4ed3@redhat.com>
Date: Tue, 26 Mar 2024 11:14:53 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Make cpuset.cpus.effective independent of
 cpuset.cpus
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Petr Malat <oss@malat.biz>
Cc: cgroups@vger.kernel.org
References: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
 <20240321213945.1117641-1-oss@malat.biz> <ZgHarUDknkJyidia@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZgHarUDknkJyidia@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


On 3/25/24 16:12, Tejun Heo wrote:
> On Thu, Mar 21, 2024 at 10:39:45PM +0100, Petr Malat wrote:
>> Requiring cpuset.cpus.effective to be a subset of cpuset.cpus makes it
>> hard to use as one is forced to configure cpuset.cpus of current and all
>> ancestor cgroups, which requires a knowledge about all other units
>> sharing the same cgroup subtree. Also, it doesn't allow using empty
>> cpuset.cpus.
>>
>> Do not require cpuset.cpus.effective to be a subset of cpuset.cpus and
>> create remote cgroup only if cpuset.cpus is empty, to make it easier for
>> the user to control which cgroup is being created.
>>
>> Signed-off-by: Petr Malat <oss@malat.biz>
> Waiman, what do you think?

I think it is possible to make cpuset.cpus.exclusive independent of 
cpuset.cpus. There are probably more places that need to be changed 
including the cgroup-v2.rst file.

Cheers,
Longman

>
> Thanks.
>


