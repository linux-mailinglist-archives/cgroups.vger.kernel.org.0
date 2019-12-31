Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1812DC41
	for <lists+cgroups@lfdr.de>; Wed,  1 Jan 2020 00:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLaXFQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Dec 2019 18:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfLaXFQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 31 Dec 2019 18:05:16 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C29C206E0;
        Tue, 31 Dec 2019 23:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577833515;
        bh=2JRDEcONOOpeU0TxkjV7WoTCxeEf9fZaWWxMhwx7i8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MRddLrwYS3egNicCrnLw9LAAmaqqevPs4Ss/3/JtxisDiy01nCs2CsIvKPioA/l6N
         pHwlAnwDnZkgDa37ZpauBUhVd5ELv4fybysP9M7sUxY35hNWTScoYqRGoH8pRWOw9b
         YdpRaUNRvib77Pmt+6vVPW285q1Umj9w2d7O0Vbo=
Date:   Tue, 31 Dec 2019 15:05:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, tj@kernel.org,
        hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com, hannes@cmpxchg.org
Subject: Re: [PATCH v7 00/10] per lruvec lru_lock for memcg
Message-Id: <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org>
In-Reply-To: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 25 Dec 2019 17:04:16 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> This patchset move lru_lock into lruvec, give a lru_lock for each of
> lruvec, thus bring a lru_lock for each of memcg per node.

I see that there has been plenty of feedback on previous versions, but
no acked/reviewed tags as yet.

I think I'll take a pass for now, see what the audience feedback looks
like ;)

