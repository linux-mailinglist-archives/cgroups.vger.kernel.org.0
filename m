Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D337197
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfFFK02 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 06:26:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFFK02 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jun 2019 06:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q4DI0TxjJulybTNuYmEqPyem4/mI+9Yg8Jh1qLDvwK4=; b=H2hUvq+nyaYp6S4MTr90JVR+1
        B8EgOOul3RJx6BFSYrr8aBDMo9szU9kjAmcGHfG+wxVvnCbT02v8AQQLoG4iwKPm87ClXsLQMMD6y
        nxpVcyw7J22nrTRm+2IogmsZSKK3toOOlrylSdrNnpqzdEAfHAVWqaf/QdXB/S4Z8j/U5gq+UsVJF
        uuU+3HvJRTJz22nZFqlvDPzSzpQqO1k8yOzt0WIYOXurnoiJqSDgmmxuyUoUeraTI/rv5+92Xkg81
        IvAW/L5n/dLOzRjvJ0p+i/NI35LYrtYpxHNwxevnI1+FaW6EbzKsdj0TQoLhiN4GRl3DQAKg2VQck
        U1cxghDOQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpbG-0007gf-M6; Thu, 06 Jun 2019 10:26:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: blk-cgroup cleanups
Date:   Thu,  6 Jun 2019 12:26:18 +0200
Message-Id: <20190606102624.3847-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

below are a couple of cleanups I came up with when trying to understand
the blk-cgroup code.
