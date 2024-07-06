Return-Path: <cgroups+bounces-3555-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADB929171
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 09:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C311F2278D
	for <lists+cgroups@lfdr.de>; Sat,  6 Jul 2024 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E51C6A7;
	Sat,  6 Jul 2024 07:21:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3981A29A;
	Sat,  6 Jul 2024 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720250514; cv=none; b=lS+kNqofGaWzsC+TQgie2pjeifvZL6lvLc0LeC6ArJw2MAJP36xBQHu3GS8guQXGKqYoGyFUh8JEO3Wr4aHeOTlPDM/Bt/2nBhpx/PPq/3nzwCaj2pjMO9hYT6oHXlFu569O0dgYG9I61ghKSW+8s0cOkbwZdvS5dHTFEVNNBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720250514; c=relaxed/simple;
	bh=4PkIHvSsshrnvwvckcHor1cUfA6KuhrSvtJeWYyvYHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5vgf+cfmNWFXSt7w9ijMPyymdQxNOUqs7mGC41qNvCshQ0Bmprcsh/X9rDJRDxpohm46sFTp5feCMjYvLHmTKMhy0M4dwxRJFMAFPkZtgfhdXlTC8MNCh6mA6TGe0gk6S63Zg4hYrBNNr8iyV7slbO7faGXkrjGJnDGP9QUqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WGMJH6ryPz4f3jkc;
	Sat,  6 Jul 2024 15:21:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6CB4F1A0189;
	Sat,  6 Jul 2024 15:21:43 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP2 (Coremail) with SMTP id Syh0CgB34YaF8Ihmzu5EBQ--.55910S3;
	Sat, 06 Jul 2024 15:21:43 +0800 (CST)
Message-ID: <c900fece-14a4-0b64-babb-053b38ed0dbe@huaweicloud.com>
Date: Sat, 6 Jul 2024 15:21:41 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v2] block: flush all throttled bios when deleting the
 cgroup
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, josef@toxicpanda.com, hch@lst.de,
 axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, yukuai1@huaweicloud.com,
 houtao1@huawei.com, yi.zhang@huawei.com, lilingfeng3@huawei.com
References: <20240627142606.3709394-1-lilingfeng@huaweicloud.com>
 <Zn3O47DUoLliwbWm@slm.duckdns.org>
 <c9802312-d9c9-f262-e1d3-9d3343255b6b@huaweicloud.com>
 <7kmlqdvltacofugn7tzg6ylu25louwnmvdfa64cgdrecpveow7@rxvvbduuvjlz>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <7kmlqdvltacofugn7tzg6ylu25louwnmvdfa64cgdrecpveow7@rxvvbduuvjlz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YaF8Ihmzu5EBQ--.55910S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw15CFy3Zry5WFWrZw4DCFg_yoWfKFgEva
	yjqa1vganxXa92kay7GFykCrW5GayUZryDX3yvqr47WryYyF1kJFW8uFZ5u343Aa1S9r9r
	GFZxJas7ur1q9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/7/2 22:25, Michal Koutný 写道:
> On Fri, Jun 28, 2024 at 10:04:20AM GMT, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
>> I think it may be more appropriate to remove the limit of bios after the
>> cgroup is deleted, rather than let the bios continue to be throttled by a
>> non-existent cgroup.
> I'm not that familiar with this part -- can this also happen for IOs
> submitted by an exited task? (In contrast to a running task migrated
> elsewhere.)
Yes, IOs will be throttled no matter whether the task that delivers them
exits.
>> If the limit is set too low, and the original cgourp has been deleted, we
>> now have no way to make the bios complete immediately, but to wait for the
>> bios to slowly complete under the limit.
> It makes some sense, it's not unlike reparenting of memcg objects, IIRC
> flushed bios would actually be passed to a parent throtl_grp, right?
Yes, flushed bios would be throttled by the parent throtl_grp.
> Thanks,
> Michal


