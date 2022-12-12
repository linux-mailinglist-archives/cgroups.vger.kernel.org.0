Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D14649A79
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 09:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiLLIx6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 03:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiLLIxk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 03:53:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918DC29;
        Mon, 12 Dec 2022 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UihVLPIukW76e6Gh9tWRjReOJ5OZce6kDic8r4IuSmU=; b=qQfZ2XqQABCzgYROcbAC+dV6vV
        AzZ9femTZMLYhSeXz6ZMH3q3bLXKukUXNn60OdfWE5u5teHQXFA5JGlrFYflhYtplVeRn5uxxl7bO
        mS3bAHKx9NiXUyqNkMI8izrJgxpK4imqcuaw3MbPRBdkUYQFVzUtxNndISwnQanEDHy/Cak7W/pQ4
        VJWAo6B1+AH/stAEuUwC+Lx5mMvyDFWUfVFKgAUkn8t3SLCVGVLuRVSyzmnxdRWxjAgUOpB56mAOC
        3w0n7+9i6g6PCzuaoMZrgeAJFsEU822SKnduSJP+JWTrQbOgkCBEAQrM8fWZ4up4G2v55wXR8j8ld
        3iA0wyXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4eYw-00AcCC-Cv; Mon, 12 Dec 2022 08:53:26 +0000
Date:   Mon, 12 Dec 2022 00:53:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, darklight2357@icloud.com,
        Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2 block/for-6.2] blk-iolatency: Make initialization lazy
Message-ID: <Y5bsBuwjcbHEjhIw@infradead.org>
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
 <Y5TRU2+s379DhUbj@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5TRU2+s379DhUbj@slm.duckdns.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> +static int blk_iolatency_try_init(char *input)
> +{
> +	static DEFINE_MUTEX(init_mutex);
> +	struct block_device *bdev;
> +	int ret = 0;
> +
> +	bdev = blkcg_conf_open_bdev(&input);
> +	if (IS_ERR(bdev))
> +		return PTR_ERR(bdev);

> +retry:
>  	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, buf, &ctx);
> +	if (ret == -EOPNOTSUPP) {
> +		ret = blk_iolatency_try_init(buf);

It's a little sad to do two block device lookups here (even if it
obviously doesn't matter for performance).  I wonder if it would
make sense to explicitly support the lazy init pattern
in blkg_conf_prep somehow.

Otherwise I'm all for the lazy init.
