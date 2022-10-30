Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08546129C2
	for <lists+cgroups@lfdr.de>; Sun, 30 Oct 2022 10:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ3J5N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ3J5M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 05:57:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFBFD102;
        Sun, 30 Oct 2022 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=53bCqPVe3GpAKeh9tw+daPPTYDSxNswAb2cUcIEPPJg=; b=vqoDNLJqMfoF/cxY4N5AfAVyxp
        vffWxkZxCxtVl6GCVSTVqVlIVH03xFG9Y1I+WqghoyA5tDF1lnRvkK2nKlo1engOnKWOGSCsH0D6r
        1mj9ezf/3ZZ0CPezYnUbQtIZoBU5W4bwxrmB3Y4dTX4QH5AY0yT22oY5jKi54OMNNs/Ob3fYQnvMO
        5Im13CDbj+xCc0lHsLeY+eKRTC+Jxl2yhsfYNK28Za792WVLGIbTyDQkOuoRLKWaxuY8fw2iohLQJ
        Q9MPDzerW+4Rk+CJuaJLlE7nnQk0WxnGpzfL8KTyth+JhltIgazyWPinNuYtzpjmFO51it2tHSRVW
        Kpi2FAeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op542-00F4Zq-9x; Sun, 30 Oct 2022 09:57:10 +0000
Date:   Sun, 30 Oct 2022 02:57:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 bio_associate_blkg_from_css
Message-ID: <Y15KdiUuYJxKBa6P@infradead.org>
References: <CAO4mrfdCeFWo4Nq=OYyiOa2qhuu3Jkft3KSosympvrFzxt+iQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4mrfdCeFWo4Nq=OYyiOa2qhuu3Jkft3KSosympvrFzxt+iQg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Oct 30, 2022 at 05:39:59PM +0800, Wei Chen wrote:
> Dear Linux Developer,
> 
> Recently when using our tool to fuzz kernel, the following crash was triggered:

This looks like jfs somehow not setting log->bdev before doing I/O.
