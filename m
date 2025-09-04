Return-Path: <cgroups+bounces-9698-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ECCB432BA
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 08:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9122E1C25374
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 06:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E94278E67;
	Thu,  4 Sep 2025 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cFWEiZjG"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E237277C8A;
	Thu,  4 Sep 2025 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968230; cv=none; b=AbsA9x/W2Yq7LJpIC7dPb67WAsmznP7qso7LoY6e6XQKGphNCcV6zi5ae9N2ZCPn5Zc+No8BPNMhL1mrZFoF/nCuMG02DpbMxfdwnfPd3HStGpND9h8RYhCSmY96TQgKJAfQ46XvA7ToMzWn7FlSrqsImkEIp54HThOQuai8UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968230; c=relaxed/simple;
	bh=7qKAlkWsv0LMREnIz1CeDqQpHCmIuikj5PPVus2RgII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw6CozqXTQd+JWQuOqPqxzoZKtNGNxXR/e+96krJgmMQB9qr6XPWqbQTnMudAJX5Oi3X4iHeLICiWaWp2a4LD6geHG2XVo+COpmyS4r8Sh8hh0pNrhSRaKEMgjcFAeTti19FUhSOgbw/SfUduGZgqNd/uWrkC6Wk/+vy71yXE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cFWEiZjG; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756968219; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j+wgm6L0f4zbJ5EdhF+5E6y+Dh1zmi0N/XQYz1rDdLc=;
	b=cFWEiZjGvkQuO1zuw3r/7G8lTld0PdF1j58ixm4gROmrw9ZMERecDofqCjGdb0tWU0XznGlLylxEkUtp+isvaTXYYnB9kSYhvBuZTM6zsVmR36nUiUKccPYNriLbTrzQH8qKl6Fv7avoqtdVvqSEnOibpyZFK5Rl/3RjYbk2+J4=
Received: from 30.221.148.63(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnEbwyP_1756968218 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 14:43:39 +0800
Message-ID: <55486bee-cf4a-4034-8a4f-941bb5730d8e@linux.alibaba.com>
Date: Thu, 4 Sep 2025 14:43:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
 <rgjlqyeqcgi43crx4mqpwi7tqxqgy7bkmjbpv7t6eiqodreydm@6pag34zcnekp>
 <aLio7Z6YolSZ2lPo@slm.duckdns.org>
 <7e05b179-90ec-449b-86a8-796f4a12180a@huaweicloud.com>
From: escape <escape@linux.alibaba.com>
In-Reply-To: <7e05b179-90ec-449b-86a8-796f4a12180a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/4 09:40, Chen Ridong 写道:
>
> On 2025/9/4 4:45, Tejun Heo wrote:
>> Hello, Michal.
>>
>> On Wed, Sep 03, 2025 at 10:03:39PM +0200, Michal Koutný wrote:
>>> On Wed, Sep 03, 2025 at 06:53:36AM -1000, Tejun Heo <tj@kernel.org> wrote:
>>>> If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become cold. It
>>>> disappears completely and CLONE_INTO_CGROUP doesn't need any global locks
>>>> from cgroup side.
>>> CLONE_INTO_CGROUP uses cgroup_mutex and threadgroup rwsem like regular
>>> migration, no? Its effect is atomicity wrt clone.
>>> Or, Tejum, what do you mean that it disappears? (I think we cannot give
>>> up cgroup_mutex as it ensures synchronization of possible parent's
>>> migration.)
>> Sorry, I was confused. We no longer need to write lock threadgroup rwsem
>> when CLONE_INTO_CGROUP'ing into an empty cgroup. We do still need
>> cgroup_mutex.
>>
>>    671c11f0619e ("cgroup: Elide write-locking threadgroup_rwsem when updating csses on an empty subtree")
>>
>> Thanks.
>>
> I'm still a bit confused. Commit 671c11f0619e ("cgroup: Elide write-locking threadgroup_rwsem when
> updating csses on an empty subtree") only applies to CSS updates. However, cloning with
> CLONE_INTO_CGROUP still requires acquiring the threadgroup_rwsem.
>
> cgroup_can_fork
>    cgroup_css_set_fork
>      	if (kargs->flags & CLONE_INTO_CGROUP)
> 		cgroup_lock();
> 	cgroup_threadgroup_change_begin(current);
>
When using CLONE_INTO_CGROUP, there is no need to write cgroup.procs. So 
although
a read lock is required here, there is no contention with the write lock.

Thanks.


