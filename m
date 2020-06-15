Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBF1F8C03
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2020 03:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgFOBLf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Jun 2020 21:11:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728039AbgFOBLf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 14 Jun 2020 21:11:35 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 08F5E6F1C9214CAB1357;
        Mon, 15 Jun 2020 09:11:32 +0800 (CST)
Received: from [10.166.213.22] (10.166.213.22) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 15 Jun
 2020 09:11:28 +0800
Subject: Re: [PATCH] cgroup: Refactor two assignments in
 css_task_iter_next_css_set()
To:     <zzuedu2000@163.com>, <James.Bottomley@HansenPartnership.com>
CC:     <tj@kernel.org>, <hannes@cmpxchg.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Markus.Elfring@web.de>,
        <songmuchun@bytedance.com>, <buddy.zhang@aliyun.com>
References: <1592158208.5303.27.camel@HansenPartnership.com>
 <20200614232224.1804-1-zzuedu2000@163.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <4d6a3864-b4b4-9b32-1349-c40b11e28a8f@huawei.com>
Date:   Mon, 15 Jun 2020 09:11:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200614232224.1804-1-zzuedu2000@163.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.22]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/6/15 7:22, zzuedu2000@163.com wrote:
> On Sun, 2020-06-14 at 18:10 +0800, James.Bottomley@xxxxxxx wrote:
> 
>> it's arguable that having two statements instead of one makes the code
>> marginally more readable.
> 
> Above the function there is a similar line of code:
> l = it->tcset_pos->next;
> One line of code makes the code style consistent and more readable
> 

It would be much better if you are fixing a bug or developing a new feature
and while at it you do this cleanup conveniently, but this patch alone has
little value. 
