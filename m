Return-Path: <cgroups+bounces-9254-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF6DB299F4
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 08:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B575D4E335B
	for <lists+cgroups@lfdr.de>; Mon, 18 Aug 2025 06:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3D277003;
	Mon, 18 Aug 2025 06:42:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC6209F43;
	Mon, 18 Aug 2025 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499361; cv=none; b=CYKvHRlLjqDImZt9cjpOrEUqkv8IS46aBvWSzRnkaakVC523uT7SycPec9YFB6BE95UsTB7CN16WidDPn3qDLt3FxJXeEYszH1A6HBMVmIy/cvtp2m4iM8lGPd7OTlMXnYpUqj65C7ZS4HPGJfvUGpsbGgh0e0f2JmiYofQ6v8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499361; c=relaxed/simple;
	bh=nwAs0aFFINWtk3kW/um6oQyqyTzq6VoxcQzO7Ik0Jf4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aBPL8uMBAX/vjrUuqrrXrM4HTyBqqgaiLjp5oBAKpEixialpT1zPW7SBYXK6v7Hie2MUm0vI4JRIWUSmBXKvsdesaRm3k+oZONGYArm6peClghwwgtHt1tkzqtAzhKrqcohl1efvyzMiUcHKzsgpKLsCVdynukf7xGVitQcqvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c536z3tJwzYQvWF;
	Mon, 18 Aug 2025 14:42:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 205F21A018D;
	Mon, 18 Aug 2025 14:42:34 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgAnM7VYy6JoRfoREA--.42486S2;
	Mon, 18 Aug 2025 14:42:33 +0800 (CST)
Message-ID: <7d180c47-07c8-4d33-ab64-f9bf31671b9f@huaweicloud.com>
Date: Mon, 18 Aug 2025 14:42:32 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cgroup: split cgroup_destroy_wq into 3 workqueues
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, hdanton@sina.com,
 gaoyingjie@uniontech.com
References: <20250818034315.1303955-1-chenridong@huaweicloud.com>
 <20250818061435.1304516-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818061435.1304516-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnM7VYy6JoRfoREA--.42486S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1kJr1UZr1rZF43Xw1kXwb_yoWkuFc_ua
	9rWrn0krZxJw4vg3yqgrn8XFZYkF45GFy8tF45tw17CF98Jwn8CrsxJr13CrWDAayxXFnx
	Gr9xGas2kwnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/18 14:14, Chen Ridong wrote:

> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..679dc216e3ed 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -126,8 +126,22 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
>   * of concurrent destructions.  Use a separate workqueue so that cgroup
>   * destruction work items don't end up filling up max_active of system_wq
>   * which may lead to deadlock.
> + *
> + * A cgroup destruction should enqueue work sequentially to:
> + * cgroup_offline_wq: use for css offline work
> + * cgroup_release_wq: use for css release work
> + * cgroup_free_wq: use for free work
> + *
> + * Rationale for using separate workqueues:
> + * The cgroup root free work may depend on completion of other css offline
> + * operations. If all tasks were enqueued to a single workqueue, this could
> + * create a deadlock scenario where:
> + * - Free work waits for other css offline work to complete.
> + * - But other css offline work is queued after free work in the same queue.
>   */

More comments are added to clarify why we split the destroy work into 3 workqueues in v5.

-- 
Best regards,
Ridong


