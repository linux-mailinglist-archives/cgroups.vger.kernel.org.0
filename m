Return-Path: <cgroups+bounces-6458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD0A2C3E7
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 14:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D763AD604
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92B1F4198;
	Fri,  7 Feb 2025 13:38:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FC1D61AC;
	Fri,  7 Feb 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935531; cv=none; b=n6f4GyqkGLg9vDjy1KDkkASBiGNE3UYHT2wWgFjVdtI/sDmyuGyJ3ow0mcBXytThGjU540CvQuFSZnYkF32CDYSiqnm/O4rSwKFoPdN9+uXD+orREeyUAz62PHPXRgdFbkbHQkuqkHXw9V6yEyrs9f0S4yWQCyIFiZrUDOLgViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935531; c=relaxed/simple;
	bh=XJvMJJCogQp4DN24ILgJgRndFwG6PAFvsTUtdxvnnGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mATTo8809/c2YIRP8Zriu8+RWAUIlv/i1XhE8IZyvgGwtnFw9Dc2iQxU/i86Wu+20DXDEfCdDYuDFD9zODoswdvf0hjZaeXapkOaPZscTEGwFyS0YILXWg2aytXlMqPfmfl0fZIgUa0LiVg4q6mnxqMQUWK/Vt7UferYYKjbY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54106113E;
	Fri,  7 Feb 2025 05:39:12 -0800 (PST)
Received: from [192.168.178.38] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56D923F63F;
	Fri,  7 Feb 2025 05:38:44 -0800 (PST)
Message-ID: <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
Date: Fri, 7 Feb 2025 14:38:32 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Jon Hunter <jonathanh@nvidia.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 11:38, Jon Hunter wrote:
> 
> On 06/02/2025 09:29, Juri Lelli wrote:
>> On 05/02/25 16:56, Jon Hunter wrote:
>>
>> ...
>>
>>> Thanks! That did make it easier :-)
>>>
>>> Here is what I see ...
>>
>> Thanks!
>>
>> Still different from what I can repro over here, so, unfortunately, I
>> had to add additional debug printks. Pushed to the same branch/repo.
>>
>> Could I ask for another run with it? Please also share the complete
>> dmesg from boot, as I would need to check debug output when CPUs are
>> first onlined.

So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
isol CPUs?

This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]

[...]

