Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B722D424E86
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhJGIGk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 04:06:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:49364 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232550AbhJGIGj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 7 Oct 2021 04:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=0BFtNW+uAic/gbXLZdgsDlSO4sw6Ifw/xoJaDaI55bU=; b=sFxVuxGF/K/sI9yRXtt
        iHelb55imrMwNRi00EL//AAgf9cXXhmdFaqfFlGjfOH9hCddiUk7c5W6sI2GLrh9HN41qQSKv/n/U
        WDKnaXDE6Fhh1q7If9NFVKPoW5fKf3hJ/EOgpbOJ+ver0iKgznhwp8QFOo0n5dKpOnV3Cr46vYA=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mYOOQ-005Ivp-TU; Thu, 07 Oct 2021 11:04:42 +0300
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: memcg memory accounting in vmalloc is broken
Message-ID: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
Date:   Thu, 7 Oct 2021 11:04:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.

Is it known issue perhaps?

thank you,
	Vasily Averin
