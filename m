Return-Path: <cgroups+bounces-8765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50701B09F8B
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919965862E0
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA8298993;
	Fri, 18 Jul 2025 09:27:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E164296163;
	Fri, 18 Jul 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830826; cv=none; b=f9g/c8xujZMRIqdB0sPtzFTF5eG54f04MY55ouU2wbWFOCRWwDBg+BzyNpc/awysEfWLkGnuhmDKn+53yh9q/6yvy5Hi7CNxDoBah0mS2ppQwuu30acC0SGvIH2jyfUwQt/V3BaKYo3ZkvkYVpXkQfJiEjYbEnRAwmA076qocaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830826; c=relaxed/simple;
	bh=HUhy81ZaP0p0/423HH16uiwt9y5XJBXuD6+67+pGmRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dv/BzeMH+3Eb42B49PJVFLIfXahGah1SUzdyVLsE+n5Q3uOrgEtwO6JhZ0WhWBz2xoMXLXtPLW5t/Fsoam5FZnjuNmgiVHGw0PcvRF/njMnAMu48Jtr6j+LHF5Vz1BD6rmfLwbtco9/8yYf5o45AKkrpWC/CiYuj+ixJK9CVq3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bk4Dw6xv6zKHN3X;
	Fri, 18 Jul 2025 17:26:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 93C491A1355;
	Fri, 18 Jul 2025 17:26:55 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBXFLBeE3po8Z6eAg--.17315S2;
	Fri, 18 Jul 2025 17:26:55 +0800 (CST)
Message-ID: <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
Date: Fri, 18 Jul 2025 17:26:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>
Cc: Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXFLBeE3po8Z6eAg--.17315S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kJrWfZF4DKr15CF1rWFg_yoW8Ar13p3
	yYy34fJa98JFW0yFs293Z8WF1Fv348Can8XF9xuw18JF1UXryj93yftayYva4akFZagw1U
	ArWa9wn7ua9FyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/18 16:20, Michal Koutný wrote:
> On Thu, Jul 17, 2025 at 07:05:14AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> I wonder what hierarchical summing would look like for this.
> 
> So do I.
> Thus I meant to expose this only in a *.local file not the hierarchical
> one.
> 
> But I realize it should [1] match cpu.stat[.local]:thottled_usec
> since they're similar quantities in principle.
> - cpu.stat:thottled_usec
>   - sums the time the cgroup's quota was in effect
>   - not hierarchical (:-/)
> - cpu.stat.local:thottled_usec
>   - not hierarchical
>   - sums the time cgroup's or ancestor's quota was in effect
>     -> IIUC this is what's the motivation of the original patch
> 
> HTH,
> Michal
> 
> [1] I'd find it more logical if
> cpu.stat:thottled_usec were cpu.stat.local:thottling_usec and
> cpu.stat.local:thottled_usec were cpu.stat.local:throttled_usec.
> Only to illustrate my understanding of hierarchy in cpu.stat, it doesn't
> matter since it's what it is now.

Hi Michal and TJ,

I'd like to raise a separate thought unrelated to the current discussion.:)

With the recent merge of the series "cgroup: separate rstat trees," the rstat are not bound to CPU
system. This makes me wonder: should we consider moving the cpu.stat and cpu.stat.local interfaces
to the CPU subsystem?

The CPU subsystem could then align more closely with other resource controllers like memory or I/O
subsystems. By decoupling these CPU-specific statistics from the cgroup core, it could help keep
both cgroup and rstat implementations more focused.

Is there any particular reason why the CPU subsystem must remain bound to the cgroup core?

Looking forward to your insights.

Best regards,
Ridong


