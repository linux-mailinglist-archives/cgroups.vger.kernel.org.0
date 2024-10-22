Return-Path: <cgroups+bounces-5176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB379A9739
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 05:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16969B21A00
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 03:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBF13B5AF;
	Tue, 22 Oct 2024 03:44:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7B322A;
	Tue, 22 Oct 2024 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568683; cv=none; b=Q7hFx/BkR/3ozDPwfd1u84vc0YitvyjIQIDLeTFhbNMEc8mgeozAzorbMDwwgYD7WXet9r+AlAYvWnj4/+qTFHbfBrgR/sZGo6n7djwBHeBmJvHOrnqqUPm6nPorIMz0eyNvnaK6ljtTLKQ1SZIC9hjEQlKpqVP7R7jlxaZdiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568683; c=relaxed/simple;
	bh=YgbWt+luvyj6U/M/28j9MXXg8bQthV1WWq11E6tvA04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brUb+1A/aF25urW/Os/1ZjD/XJO1yIPgWV3IvCFtiwAiNyGBWyY4iGGtN3QomxDH6SILAoSaVmWYTFSNPj01k96FgiM/b9En4mwJDe0tWKaGM5dvJscP4+AuwoYZnMdCWYm0VGs8Yqszc/gm9nmGxVn17jdbEcHkIOImCOqomDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXdMl6f9Zz4f3jY4;
	Tue, 22 Oct 2024 11:44:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4BBB91A0194;
	Tue, 22 Oct 2024 11:44:37 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMihHxdn2ikYEw--.26094S3;
	Tue, 22 Oct 2024 11:44:35 +0800 (CST)
Message-ID: <eedc01d5-42f9-39f0-25c4-340f35ee8eab@huaweicloud.com>
Date: Tue, 22 Oct 2024 11:44:33 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v2] blk-cgroup: don't clear stat in blkcg_reset_stats()
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk,
 longman@redhat.com, ming.lei@redhat.com, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, yukuai3@huawei.com, lilingfeng3@huawei.com
References: <20240821020756.786000-1-lilingfeng@huaweicloud.com>
 <migrlemuqjqff6y64o6ukfkuil6uwuarwvyg3xymfphnicznna@sy5dwhovytuz>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <migrlemuqjqff6y64o6ukfkuil6uwuarwvyg3xymfphnicznna@sy5dwhovytuz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnXMihHxdn2ikYEw--.26094S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy8Xw17Zw4DuF43WF1kAFb_yoW8AFyUp3
	4DAF90ka1kJr1kA3yxCw4fZr1Fgw4ft345GF98J34FkF1qqr92qr40yw45ZFyDGa4Ikw10
	qr45Z34vk345ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUFku4UUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/8/21 23:51, Michal Koutný 写道:
> Hello.
>
> On Wed, Aug 21, 2024 at 10:07:56AM GMT, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
>> The list of root cgroup can be used by both cgroup v1 and v2 while
>> non-root cgroup can't since it must be removed before switch between
>> cgroup v1 and v2.
>> So it may has effect if the list of root used by cgroup v2 was corrupted
>> after switching to cgroup v1, and switch back to cgroup v2 to use the
>> corrupted list again.
>> However, the root cgroup will not use the list any more after commit
>> ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup io.stat").
> How come? Before that patch the root file was excluded with
> CFTYPE_NOT_ON_ROOT. IOW how has that patch an effect on llist traversal?
>
> (It doesn't matter, your patch doesn't restore memset anyway.)
>
> This is the reasoning how I understand it:
>
> | The removed function clears blkg.iostat structures that is only used on
> | v2 whereas the function can only be called with v1 hierarchy attached.
> | Zeroing effect could potentially be visible root blkcg "shared" between
> | v1 and v2 but v2 actually synthesizes stats differently for root.
Yes, that's what I mean.
>> Although this has no negative effect, it is not necessary. Remove the
>> related code for cleanup. No function change.
> I'm impressed by the amount of analysis you did to potentially remove
> the unused function. If you feel like cleaning up more or sectioning,
> see also [1] or [2] for inspiration.
Thank you for your advice. I'll look at them later.
> Thanks,
> Michal
>
> [1] https://lore.kernel.org/all/20240625005906.106920-14-roman.gushchin@linux.dev/
> [2] https://lore.kernel.org/all/20240628210317.272856-1-roman.gushchin@linux.dev/


