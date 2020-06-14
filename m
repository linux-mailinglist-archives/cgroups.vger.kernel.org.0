Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09AD1F8B49
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2020 01:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgFNXXd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Jun 2020 19:23:33 -0400
Received: from m12-15.163.com ([220.181.12.15]:51623 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgFNXXd (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 14 Jun 2020 19:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=SOGSMjP33qpL7ktNpZ
        lBjEhRk3kAp4OIE+OmxCw5kOM=; b=mnHKcxVeVzwxurr41nI19pY9PG8iqDcOa3
        ZY1WReuIr0YbNRQKvxkX7rx/9z9jbEbVgBKPROzjBeruIk5kr13EtnnWViphk20l
        kUc4F/BpsDzbq2md+zXZnTr0sYZD2dIRSi4KDc3d4O8aGPN17tZJBHmRTno5f/ih
        ddlA9kHkk=
Received: from localhost.localdomain (unknown [111.202.190.28])
        by smtp11 (Coremail) with SMTP id D8CowAAXH4s6seZeGdtvGw--.51482S2;
        Mon, 15 Jun 2020 07:22:34 +0800 (CST)
From:   zzuedu2000@163.com
To:     James.Bottomley@HansenPartnership.com
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, songmuchun@bytedance.com,
        buddy.zhang@aliyun.com
Subject: Re: [PATCH] cgroup: Refactor two assignments in css_task_iter_next_css_set()
Date:   Mon, 15 Jun 2020 07:22:24 +0800
Message-Id: <20200614232224.1804-1-zzuedu2000@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1592158208.5303.27.camel@HansenPartnership.com>
References: <1592158208.5303.27.camel@HansenPartnership.com>
X-CM-TRANSID: D8CowAAXH4s6seZeGdtvGw--.51482S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU8Xo2DUUUU
X-Originating-IP: [111.202.190.28]
X-CM-SenderInfo: p22xvvbxsqiii6rwjhhfrp/1tbioxpDQlUMSsfoJQAAsh
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 2020-06-14 at 18:10 +0800, James.Bottomley@xxxxxxx wrote:

> it's arguable that having two statements instead of one makes the code
> marginally more readable.

Above the function there is a similar line of code:
l = it->tcset_pos->next;
One line of code makes the code style consistent and more readable


Regards,

Wei Fenghai

