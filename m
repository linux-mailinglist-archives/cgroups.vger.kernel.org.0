Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E33278DCE
	for <lists+cgroups@lfdr.de>; Fri, 25 Sep 2020 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIYQPK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Sep 2020 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIYQPK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Sep 2020 12:15:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FEC0613CE;
        Fri, 25 Sep 2020 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Y2wH4RuuuVJ7MQ/4jAkTQlQ8pcaD870YXfRn/rEdzlM=; b=SLodffWn1lQtoi5MM/yWwKew1R
        MTEG36QLz4sz4acbWW05Ij1EEUpGF15Wk6lyQ984odhtMINUxwiu5MwQKHpqtKXpu98MPoha8Sd2/
        xhw2YUWpTnZFrPBQ9+bwSA/sMjCTVoIa06CD92ZuRVsEcnz9OUNdaOL/eF8HAIQFkxf1WNvuZPszV
        7oXxZzM6RX2u67NWZSfg1pgjzPVy4D91QKIawJAP3v/lO7jYfTF8mnjN+o4BrhKgI32qxLmYjh2bH
        n3k9L0rQ0w6r7nN652Ste7tORJKiS5TgOgxma13HGDwPxmwtkL0YJHMjVWocYuU9WGqz1Tvo5o9vh
        dczfcGJA==;
Received: from [213.208.157.35] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLqN5-0003ve-U6; Fri, 25 Sep 2020 16:14:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Minho Ban <mhban@samsung.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: RFC: sort out get_gendisk abuses
Date:   Fri, 25 Sep 2020 18:14:45 +0200
Message-Id: <20200925161447.1486883-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

this series tries to remove two abuses of the get_gendisk API.
The first one is fairly straigt forward and switched the blk-cgroup
configuration API to properly open the block device, but I'd love to see
it reviewed and tested by the cgroup maintainers, as I don't really know
how this code is actually used.

The other one in the hibernation code really puzzles me - it busy loops
on the gendisk lookup, just to leak a reference when it finally succeeds
and then doesn't actually do anything with the result.  My proposal for
now is to simply revert the offending change, but better proposals are
welcome.
