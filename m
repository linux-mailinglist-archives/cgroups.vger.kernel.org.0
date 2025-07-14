Return-Path: <cgroups+bounces-8719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A78B03510
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 05:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A4C1897AB3
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 03:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F2A1DDA34;
	Mon, 14 Jul 2025 03:53:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC078F26
	for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 03:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752465202; cv=none; b=n68pidIVEZNsNA+67V1+eDCVTM31yGFzNPqXadyp0Lg0DmFpGuzl2BAgr8pq9wLVhb+6Ytb0jvZnwxSTr45f17bTG6pE8NEhNAtNsb4CUjbSbx+hHGhCwB/hJ3y593WU+xORC+j+pey7S/NFp1sZ4bK1Tu95IX84+FgwZIJg9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752465202; c=relaxed/simple;
	bh=BknQK1d0ePxqivMyohelZTZehS1ILrhazGmDBeyDIro=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NSe93LD9fLyBY3O4fWKgXmh0VgPCWtmlaFJ2uW6sVftiC/kQHX6NqsMxb5uUpnG6KjWwLhu0WgYbzZl7xnWTF08KowN73GNeQO17+WQ6C8NA8n/7sHeCTJAcl3KaXuk7RDwrKTosCKgCac8Zfu2zjls5ZO29u73pNg0zg/C8z38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bgT1n0jPZzKHLxX
	for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 11:53:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A4C0F1A111E
	for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 11:53:15 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDnVrIof3RoG5TJAA--.10221S2;
	Mon, 14 Jul 2025 11:53:14 +0800 (CST)
Message-ID: <b9a3d8da-9fd8-4ffe-b01e-4b3ecef5e7a6@huaweicloud.com>
Date: Mon, 14 Jul 2025 11:53:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel defect causing "freezing user space tasks failed after 20
 seconds" upon deep sleep
To: Xuancong Wang <xuancong84@gmail.com>, cgroups@vger.kernel.org
References: <CA+prNOqAG31+AfgmchEMbeA=JpegKM946MZPm4TG0hEXDDRUag@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CA+prNOqAG31+AfgmchEMbeA=JpegKM946MZPm4TG0hEXDDRUag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDnVrIof3RoG5TJAA--.10221S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy7tw4xGr4UGF4xXFW8Zwb_yoW8WF1Dpa
	9Y9ay3Gas8Jr1fAw4kJw1Iga4UArWfA3y5JFn8Kw1fAa90gF1q9ryIkF15WFy7Xr9a9FWj
	qrn2vFyY9w4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/12 12:51, Xuancong Wang wrote:
> Dear Linux kernel developers,
> 
> I am referred from
> https://github.com/systemd/systemd/issues/37590#issuecomment-3064439900
> to report the bug here.
> 
> In all recent versions of Ubuntu (mine is Ubuntu 22.04 LTS), deep
> sleep will typically cause the error "freezing user space tasks failed
> after 20 seconds" and then the desktop will hang. To 100% reproduce
> the bug:
> - lid-close operation set to suspend/sleep
> - sleep type set to deep sleep `echo deep > /sys/power/mem_sleep`
> - SSHFS mount a reasonable-size Python project folder with a
> anaconda3/miniconda3 folder inside it
> - install VS code (version >=99) with Python parsing plugins
> - use VS code to open the Python project, set interpreter to that
> anaconda3/miniconda3 located on the SSHFS folder
> - while VS code is parsing the project (spinning gear in status bar),
> close the lid or run pm-suspend
> 
> You will see that the laptop does not go to sleep (sleep indicator LED
> does not light up), after 20 seconds, open the lid, the desktop hangs
> with the error message, "freezing user space tasks failed after 20
> seconds".
> 
> Only reboot or `systemctl restart gdm` can recover the desktop, all
> unsaved data are lost.
> 
> Cheers,
> Xuancong

Hi, Xuancong,

What's your kernel version? Are you using cgroup v1?

There are two issues I know about legacy freezer. Wish this can be helpful.

https://lore.kernel.org/lkml/20250703133427.3301899-1-chenridong@huaweicloud.com/
https://lore.kernel.org/lkml/20250618073217.2983275-1-chenridong@huaweicloud.com/

Best regards,
Ridong


