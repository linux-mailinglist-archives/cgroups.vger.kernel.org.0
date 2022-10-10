Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D95F9A3E
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiJJHnH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiJJHmZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 03:42:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F611114C;
        Mon, 10 Oct 2022 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NMxgP/FowzLAsvzkIOCbfXDAaqlRHaeSOJVqOvK8ueY=; b=jfESnPEgf6DUuY25FlxRg/rFE7
        XJJAifuTda3jbdwAcm0O5obHOq0zPY9jRlzI9zT1fOXiJwvLvygK/G2T8xPpDEm0pjlVHXQI+gxkw
        3Ffn1eYqyYjp7OlTDFfUIsDXFaJwpCtZ/h7KCtDRIiCZh/9Cf7peiQCEQ0pPBz0py7f3cnH7oma2Q
        PIO4YZAs4x2gU1jX7B4Nn7TMFvP7lDLPWT9//+E09+QVTk3yQOruxTJewxCpjfNAeBcMdH6xiz/+t
        tavKqa8sKRJB5HHpl/mDSZHUctjpLCE5qx3Omgcy2UG1Pb+yNixnm54w38wl/tIg1FX4ZkfyTL1PL
        zvw70Lsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnM2-00HOsZ-Qy; Mon, 10 Oct 2022 07:37:38 +0000
Date:   Mon, 10 Oct 2022 00:37:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] blk-cgroup: Remove unnecessary blk_ioprio_exit in
 blkcg_init_queue
Message-ID: <Y0PLwj/l/l4QPpTC@infradead.org>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-2-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010023859.11896-2-shikemeng@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 10:38:56AM +0800, Kemeng Shi wrote:
> Function blk_ioprio_init only alloc blkg_policy_data which will be freed
> in blkg_destroy_all, so no blk_ioprio_exit is called when blk_throtl_init
> is failed in blkcg_init_queue. Also blk_ioprio_exit is not called in
> blkcg_exit_queue for the same reason. Just remove blk_ioprio_exit to
> keep behavior consistent.

This code looks very different in current mainline.

