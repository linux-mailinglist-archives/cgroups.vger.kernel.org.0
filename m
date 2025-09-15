Return-Path: <cgroups+bounces-10072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2840B577E9
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6933B711A
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46F82D8387;
	Mon, 15 Sep 2025 11:18:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91289EAF9;
	Mon, 15 Sep 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935122; cv=none; b=LVjQA472l96T6LJ3IylnPLflxVoJ+K5u9oTL6bAepkO1hLy06mGb8i/5wkwpNJ9jdtndM9Z5j7Fq4sAOSHECvDx0BID2chtQNplzmHPPRmWS7gUF7jDm+IS7RT7n4Do1oh/Mt3ntGmiz5XNdQmpOAMLxmt9OEDMMBYzJJLzPijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935122; c=relaxed/simple;
	bh=f0hmLvMuvCxh8nkmja7MUq5f2MYxAtl9YZaE7Pxk3h4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m/Ig2BFQidOANbyPJ/LJ/ySMwd5NqhN2weNeSTh2KGtsHgVI5B/KpaYHY3fGG5QlmroIPl7awBs2vHp13Jc11UChLKX4SHcMDbPU4Thz92O7u0y9k1u6VKi4f+XbPIKI8IGAVMy29uRr+B6iALtVS82zEFsaNjdSEqKyZ3m4Oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cQMwZ3GGVzYQvsN;
	Mon, 15 Sep 2025 19:18:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0B9CA1A0C12;
	Mon, 15 Sep 2025 19:18:37 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgDXcmoL9sdo8NktCg--.1840S2;
	Mon, 15 Sep 2025 19:18:36 +0800 (CST)
Message-ID: <3861018c-96a2-4055-94ca-39f7a8e631f3@huaweicloud.com>
Date: Mon, 15 Sep 2025 19:18:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 00/11] Refactor cpus mask setting
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDXcmoL9sdo8NktCg--.1840S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kur1DWw18Kw4UGw1fCrg_yoW8XF13pF
	WY93WkAa95Gr18K3Z7u3yxWF40ga1Dt3W7JFn5t34xJr109F1qyryktas8uFy3Gr9xG34U
	ZayaqanavF9rA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/9 11:32, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This patch series refactors the CPU mask configuration logic for both
> cpuset.cpus and cpuset.cpus.exclusive settings. The primary goal is to
> improve code readability through comprehensive function restructuring.
> 
> The CPU mask update process follows these steps:
> 1. Parse user input
> 2. Skip processing if no actual change to CPU mask
> 3. Compute trial cpuset's effective exclusive CPUs
> 4. Validate changes and return error if invalid
> 5. Handle partition state changes resulting from CPU mask modifications
> 6. Apply new CPU mask to the cpuset
> 7. Propagate changes through the hierarchy
> 
> The series is organized as follows:
> patches 1-3: Code cleanup and preparation for refactoring
> patches 4-9: Refactoring of cpuset.cpus configuration logic
> patches 10-11: Refactoring of cpuset.cpus.exclusive configuration logic
> 
> ---
> 
> Changes from v1:
> - Patch 1: Use direct comparison (cs == &top_cpuset) instead of the
>            cpuset_is_root() helper function
> - Patch 6: Updated comments for better clarity
> - Patch 7: Refactored validate_partition to replace the previous
>            invalidate_cs_partition implementation
> - Patch 8: Renamed acpus_validate_change to cpus_allowed_validate_change
> - Patch 9: Updated commit message with more detailed information
> 

Hi, Longman,

I would be grateful if you could take a look at this series when you have a moment.

-- 
Best regards,
Ridong


