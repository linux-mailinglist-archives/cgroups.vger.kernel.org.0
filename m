Return-Path: <cgroups+bounces-5880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934D9F01EB
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 02:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD97288014
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19397DDDC;
	Fri, 13 Dec 2024 01:18:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521510F7;
	Fri, 13 Dec 2024 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052693; cv=none; b=bZrLPM4TM0NFHzNO6rRPdCsHiKXcz/wKELjOBYjdhYF3SVoGgu4LY0o0WhbYouyWayJmSMiVYQCUMemsbF9Uomh9HxZ7DyAGYUmM5xXyKFukfSe2T3dfqy8LYRqZgTE39EHglfo/dlF78ZlRxiy+b2xEVqZvzPVdge9LLViPpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052693; c=relaxed/simple;
	bh=gTE1N93sFqKn2I3sZ6f2P2R4bz+rKmvD57/AzoSgZoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrIRazL2PMwtAdzWsbh0BS9aytrsust2JQjSNwh9AZLtRMvq1Z4qAjRQ14VO1zQ4C7ARFje5I6jaNQp9E8oGe3IJcWvXa4uZTMsXz8b2860RnjZFqjuDHa6+Ge4hFmpFsRB8/cm3x+djueHM+LQjUGKmklVoNj2oki8jt47LLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y8Wfh4PJ4z4f3jq4;
	Fri, 13 Dec 2024 09:17:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E62C01A058E;
	Fri, 13 Dec 2024 09:18:02 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBXTK5Ji1tnIfpREQ--.28484S2;
	Fri, 13 Dec 2024 09:18:02 +0800 (CST)
Message-ID: <24568f8a-f31d-4349-8641-b4c1450ce93c@huaweicloud.com>
Date: Fri, 13 Dec 2024 09:18:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, peterz@infradead.org,
 Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
 cgroups@vger.kernel.org
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
 <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
 <2f755161-ec7e-4785-b0ca-ea68c01785a2@huaweicloud.com>
 <ZzajsLHrXXtYk04l@slm.duckdns.org>
 <3b03520e-775d-416a-91b1-1d78f3e91b1d@huaweicloud.com>
 <c56b2347-7475-4190-85a5-a38954ae9c08@huaweicloud.com>
 <j5kjjy5ibp2yw4zhaxc7jm5bw65we4oifhawlljvtjzdox5ck2@kdgpgawwr7kf>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <j5kjjy5ibp2yw4zhaxc7jm5bw65we4oifhawlljvtjzdox5ck2@kdgpgawwr7kf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXTK5Ji1tnIfpREQ--.28484S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/12 0:02, Michal Koutný wrote:
> Hi.
> 
> On Wed, Dec 04, 2024 at 09:52:15AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> Does anyone have any opinions?
> 
> When an 'R' task is frozen (v1) and it's shown as (unchanged) 'R' it's
> acceptable.
> When an 'S' task is equally frozen and its apparent state switches to
> 'R', I agree it's confusing.
> 
> Showing 'D' state in any case of a frozen task (like before that rework)
> makes sense too. Please add Fixes: if you need to restore this behavior.
> 
> HTH,
> Michal

Thank you, Michal. I will update.

Thanks,
Ridong


