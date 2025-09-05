Return-Path: <cgroups+bounces-9720-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D3DB44CB5
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 06:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC825652DD
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333201F582F;
	Fri,  5 Sep 2025 04:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LiioyaSi"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9528E0F;
	Fri,  5 Sep 2025 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757046657; cv=none; b=DcLrPXq8+gQ4MGwE62HwVF5VDL/Sy5+2wo7a2y78rKWezXC3KpieRytFfZAC+Mb8+2CoDn45fbCq7fejF0sUlS1G3EjiqInhbeogZN7a9LAzxNEGAdGFxK6pQ/eU+fBDWwW0QzeL/0BU/DZEWJjjNziICmYa4GrUKz3wtuVsZ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757046657; c=relaxed/simple;
	bh=zAhUTgpz4Yw6viGF6/tPJ9qUca79BHvt+Ld+5HqAkaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/AuRfdGNIyz8aFSAy8uTcbXDrDEXazaVY64CDFv6D/iBYHN8NN6Cw5czKl8twrKPwEz2TGgRnnMEDZq8lrtQy9LOmbUiLdXeYSwe1H2PZAPkR7aNrao/9de1qGq8XfN7/D3D3upTqWk87U9EA+pxnttMSaCf6sZ+XDpbB0Xqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LiioyaSi; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757046651; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zAhUTgpz4Yw6viGF6/tPJ9qUca79BHvt+Ld+5HqAkaA=;
	b=LiioyaSixOiD5QUeOKaCPpKGCKmCxmFAWLyCzfi2v5OYEFvbFkTlFHdLQAQN2oYzy6O8ee0TqcLG26R9QGn+SZCt/iWLyybO8WezKLwN1Mltx3JLpq9P/jJNOGVU08flhJR7h3Odf51t+eDICWAhHM+mR8RHZV48qV0GeZ0dz4U=
Received: from 30.221.148.72(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnJ3I1Q_1757046649 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 12:30:50 +0800
Message-ID: <b0b5766d-e683-41bb-9a8c-00723478d68f@linux.alibaba.com>
Date: Fri, 5 Sep 2025 12:30:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1756985260.git.escape@linux.alibaba.com>
 <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>
 <aLm-2Lcnu602AB85@slm.duckdns.org>
 <11edd1da-7162-4f5a-b909-72c2f65e9db7@linux.alibaba.com>
 <aLpKr6_r5exdc3EQ@slm.duckdns.org>
 <93b146e5-08e4-4c10-bb90-8149e82263f0@linux.alibaba.com>
 <aLpdc4oDdAxvtUQT@slm.duckdns.org>
From: escape <escape@linux.alibaba.com>
In-Reply-To: <aLpdc4oDdAxvtUQT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/5 11:48, Tejun Heo 写道:
> Hello,
>
> On Fri, Sep 05, 2025 at 11:44:53AM +0800, escape wrote:
> ...
>> To avoid the complexity of runtime changes to favordynmods, perhaps a
>> better approach would be to introduce a separate control variable,
>> configured via a kernel command line parameter such as
>> cgroup_migration_lock=[global|thread_group] to explicitly govern this
>> behavior. What do you think about this approach?
> Can't you just down_write threadgroup_rwsem when flipping the flag? Wouldn't
> that provide sufficient synchronization?
>
> Thanks.
>
You're right, it's clear and simple. I will make the changes in this way.

Thanks.

