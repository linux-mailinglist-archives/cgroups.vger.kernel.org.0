Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44236300C1
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfE3RN7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 13:13:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfE3RN7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 13:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QXNL9kos3vvhr0YBbrXLE6785Sr0j7K/kyJsGRxCWZo=; b=aCW4rmAy7Pfqx+sC1ow5UzLj5
        S3cVvA1W0r84fyjvp6WDkz705BtgL4tr8bA4RNheok9Z87NBGbO6IxB8x3gy7psxD5OrdO2Fr0Dr3
        BzgQNIlDoeNoC0txb++rY4wo7shwMCprqrJdGMvJ0gKfOVWGdfaC3LP8AhGvLZUfpUzJ8vM2Q722l
        G44gEhQemLG44xdWe2W7d1eUtjnz0TIlF1JHnZOBc4DEJfGBJIVY2E8zqSoJq72uluhFxnEiWwMcx
        5mSIzsVzkijJCx1iiqp0lGzjaxU6+Ye0COktFH1ahbrAL5COgyMbYYt6K6oPY1l7wpncviyxbSSVc
        DkWVPJ30Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWOcn-0005ZU-0N; Thu, 30 May 2019 17:13:57 +0000
Date:   Thu, 30 May 2019 10:13:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix page cache convergence regression
Message-ID: <20190530171356.GA19630@bombadil.infradead.org>
References: <20190524153148.18481-1-hannes@cmpxchg.org>
 <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org>
 <20190530161548.GA8415@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530161548.GA8415@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 30, 2019 at 12:15:48PM -0400, Johannes Weiner wrote:
> Are there any objections or feedback on the proposed fix below? This
> is kind of a serious regression.

I'll drop it into the xarray tree for merging in a week, if that's ok
with you?
