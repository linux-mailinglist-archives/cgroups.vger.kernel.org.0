Return-Path: <cgroups+bounces-12243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6ADC99B60
	for <lists+cgroups@lfdr.de>; Tue, 02 Dec 2025 02:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 921DA3448B6
	for <lists+cgroups@lfdr.de>; Tue,  2 Dec 2025 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3981DE8AF;
	Tue,  2 Dec 2025 01:12:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7C3F9D2;
	Tue,  2 Dec 2025 01:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637970; cv=none; b=hL/NS65r5lHscJqNqBlq7y7CAfQ6vlCnGelJ71pfcxPWtq4ILIppxutAO+UcLb6UhSlhPWRuRHAj2dMuvbpdglo09E78aZqCK7HJFc0se2SLKyMm7bLLDhQNShYjYY5bSGq2eNnOYMa6TGLWkZmdqhCawN8D9m4sPTUnVOhLDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637970; c=relaxed/simple;
	bh=HOwPBcBA7eOyjeOqXZXNLeCQaq6wBNlpqLA/c/ujtNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ixQj+Lp9Xezb7O9z19FiMDgRoQelDpmXR3pdsmgA/vDgoks5s3SA71+yiN91yvxm1eR9T31i7kfNYKRjtwhP8ETcp7KdxmWHJLCPZEs2awzHzHfrOal4IaWamPcxP4s6L/S7OYpzL0hVUjO2PHVeg5keH6ApzD3wevejTH462pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dL2nS3DnczYQtfp;
	Tue,  2 Dec 2025 09:12:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 52D291A018D;
	Tue,  2 Dec 2025 09:12:45 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAH51AMPS5p0y0pAQ--.24140S2;
	Tue, 02 Dec 2025 09:12:45 +0800 (CST)
Message-ID: <101c5f3a-5614-47aa-8d62-c0b7d6baea5b@huaweicloud.com>
Date: Tue, 2 Dec 2025 09:12:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Use descriptor table to unify mount flag
 management
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251126020825.1511671-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251126020825.1511671-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAH51AMPS5p0y0pAQ--.24140S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45Xw48Kry3tw1fGw1DAwb_yoWDCwbEgw
	4S9w4qkayjvrnxKrs09FZ8uFZa9ay7Cr1xGrykXryUKw4UXFWDuFsavFy5Ar17A3ZrAFnx
	CrnIyrs5uFW2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/26 10:08, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The cgroup2 mount flags (e.g. nsdelegate, favordynmods) were previously
> handled via scattered switch-case and conditional checks across
> parameter parsing, flag application, and option display paths. This
> leads to redundant code and increased maintenance cost when adding/removing
> flags.
> 
> Introduce a `cgroup_mount_flag_desc` descriptor table to centralize the
> mapping between flag bits, names, and apply functions. Refactor the
> relevant paths to use this table for unified management:
> 1. cgroup2_parse_param: Replace switch-case with table lookup
> 2. apply_cgroup_root_flags: Replace multiple conditionals with table
>    iteration
> 3. cgroup_show_options: Replace hardcoded seq_puts with table-driven output
> 
> No functional change intended, and the mount option output format remains
> compatible with the original implementation.
> 

Hi all,

Would anyone be interested?

-- 
Best regards,
Ridong


