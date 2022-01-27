Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950DE49D824
	for <lists+cgroups@lfdr.de>; Thu, 27 Jan 2022 03:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiA0Cpi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 21:45:38 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32064 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiA0Cph (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 21:45:37 -0500
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JklGX36yRz1FCpq;
        Thu, 27 Jan 2022 10:41:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 10:45:35 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 10:45:34 +0800
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
To:     Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>
CC:     <mkoutny@suse.com>, <paulmck@kernel.org>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
 <20220110134758.2233758-3-yukuai3@huawei.com> <Yd5FkuhYX9YcgQkZ@T590>
 <b416e6a6-f2c9-caf3-dacd-f937746207da@huawei.com>
 <YfF+yukISfkuc9IK@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <630c162b-8bdd-d87e-0d80-c7a78ea267a5@huawei.com>
Date:   Thu, 27 Jan 2022 10:45:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YfF+yukISfkuc9IK@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/01/27 1:03, Tejun Heo Ð´µÀ:
> On Mon, Jan 24, 2022 at 11:50:11AM +0800, yukuai (C) wrote:
>> Both ways can fix the problem, which way do you prefer?
> 
> Ming's suggested change seems simpler, no?

Hi,

Yes, if Ming don't mind, I can send a new version after Ming's
pathset "block: don't drain file system I/O on del_gendisk".

Thanks,
Kuai
