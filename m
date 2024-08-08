Return-Path: <cgroups+bounces-4173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98A594C349
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FA4287405
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A4190676;
	Thu,  8 Aug 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wRUIUBQj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6719049A
	for <cgroups@vger.kernel.org>; Thu,  8 Aug 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136603; cv=none; b=OXnxDR2gsqI/gxLLj2xEMhoFzbEfDYXPm69ficWd6qZFiXI1w69S9YAxb2SMvetQg39VsbZmITqJxFQWph6ry3CZAEgSS7gXhQBEcU0o7FViZxaGqPCV42jcQ26bf3OcEWhfEih5OLcR539ntwfQEuQGUxZe8B5rwdSfvByQDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136603; c=relaxed/simple;
	bh=ihQb0I3WgYoE2XrU+Z6LvbSlpPClAqC+qpIj0bqqqW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUbs2cMkvYb6uh+a7hBE6etUCt9iGq65l7jLJY2uTT6azHaPe1rUVdy4UtBthv1o1BGTBflVn2svdqHEOh7WhikNbdknN+0LfR4WeExvqn5wTy7p28LK2ofbtCPpq4G+OWVhHVl7SHcH7nLSRlJrr7HVR0oMi9Uzh7gxV41tio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wRUIUBQj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 8 Aug 2024 17:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723136599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDecU1wXSp3ftwbMT3/0o0Lz4Kzs8iM6+w9Zo7Y8cYY=;
	b=wRUIUBQj28SOBua7hLGw5nG7c8/9hIuLN+e/6Q810vGKDzcBHIl2Cnhu/CC6zdvf269WoA
	nmuy1s35EYHqWRrjPj1S6qhEVW8CVMFaQlR8TvVwzx7FbQSUd9dmugCvDD7XPHRXcUp/97
	Q5XpvEkZGpTjtSKI85ZgkdHYJzuNVYo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: chenridong <chenridong@huawei.com>, Hillf Danton <hdanton@sina.com>,
	tj@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <ZrT6UuLsfULr4eJ5@google.com>
References: <20240724110834.2010-1-hdanton@sina.com>
 <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
 <ohqau62jzer57mypyoiic4zwhz2zxwk5rsni4softabxyybgke@nnsqdj2dbvkl>
 <e7d4e1ce-7c12-4a06-ad03-1291dc6f22b5@huawei.com>
 <mxyismki3ln2pvrbhd36japfffpfcwgyvgmy5him3n746w6wd6@24zlflalef6x>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxyismki3ln2pvrbhd36japfffpfcwgyvgmy5him3n746w6wd6@24zlflalef6x>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 07, 2024 at 03:32:59PM +0200, Michal Koutny wrote:
> Hello.
> 
> On Sat, Jul 27, 2024 at 06:21:55PM GMT, chenridong <chenridong@huawei.com> wrote:
> > Yes, I have offered the scripts in Link(V1).
> 
> Thanks (and thanks for patience).
> There is no lockdep complain about a deadlock (i.e. some circular
> locking dependencies). (I admit the multiple holders of cgroup_mutex
> reported there confuse me, I guess that's an artifact of this lockdep
> report and they could be also waiters.)
>
> ...
>
> The change on its own (deferred cgroup bpf progs removal via
> cgroup_destroy_wq instead of system_wq) is sensible by collecting
> related objects removal together (at the same time it shouldn't cause
> problems by sharing one cgroup_destroy_wq).
> 
> But the reasoning in the commit message doesn't add up to me. There
> isn't obvious deadlock, I'd say that system is overloaded with repeated
> calls of __lockup_detector_reconfigure() and it is not in deadlock
> state -- i.e. when you stop the test, it should eventually recover.

Thanks, Michal! I've exactly same feelings about this change.

