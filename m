Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A5D20EAC8
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2020 03:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgF3BSa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 21:18:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6881 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgF3BS3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Jun 2020 21:18:29 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0C4E0792D763124CADE7;
        Tue, 30 Jun 2020 09:18:22 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 30 Jun
 2020 09:18:21 +0800
Subject: Re: [PATCH] doc: cgroup: add f2fs and xfs to supported list for
 writeback
To:     Eric Sandeen <sandeen@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>
CC:     <cgroups@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-xfs <linux-xfs@vger.kernel.org>
References: <c8271324-9132-388c-5242-d7699f011892@redhat.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <31275d10-37c3-db32-9d0d-f78f1dd4fe0d@huawei.com>
Date:   Tue, 30 Jun 2020 09:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c8271324-9132-388c-5242-d7699f011892@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/6/30 3:08, Eric Sandeen wrote:
> f2fs and xfs have both added support for cgroup writeback:
> 
> 578c647 f2fs: implement cgroup writeback support
> adfb5fb xfs: implement cgroup aware writeback
> 
> so add them to the supported list in the docs.

Thanks for the fix.

> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
