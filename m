Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE0D6129BE
	for <lists+cgroups@lfdr.de>; Sun, 30 Oct 2022 10:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJ3Jze (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 05:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ3Jze (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 05:55:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BBCE39;
        Sun, 30 Oct 2022 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g7Lk2AACYfeSSiMJolbOzZmDEQzhYOjjt7qCWTh9D7c=; b=ppG1biGCc1of+Ow35yp36kix63
        jxcRvFnP4kJarQFIsgiJcoL1fby9wRTSG/y4WgqohBEYmonaa+FUYe0Rh6HJj75Dxb8TlbmaEcbor
        uUbCyScp6AlduacOrjubqONaTRUMcGm+etDbIs+royqhL9LxRhvGLbRWGc3pg9Zp6PLkpDpqGZRe1
        lRsZZdFCIPFoYdrdy4ShrBJEYuwzG1bwy+IFqc3wLeS/D0smO5ZRk59TNPVQjZ/owHbE4C/Gvj8Ei
        W0wADly4N6Dnawu4BxLJhGJZjEqSDu5sgbOhiDuFwRzmeBojCGwou0eoeXrzLEwIPrjdk9rhbvVuY
        Mq6DleTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op52J-00F3jm-Va; Sun, 30 Oct 2022 09:55:23 +0000
Date:   Sun, 30 Oct 2022 02:55:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 4/5] blk-iocost: fix sleeping in atomic context
 warnning in ioc_qos_write()
Message-ID: <Y15KC8Zb3rHlfTPu@infradead.org>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
 <20221028101056.1971715-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028101056.1971715-5-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This seems a little convoluted to me.  I'd suggest to add a new
sleeping lock that protects the updates, then you just take the
spinlock after parsing without much other changes.

(The same comment also applies to patch 5).
