Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878B688B9D
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 01:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjBCAQL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 19:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBCAQH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 19:16:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BC88715B;
        Thu,  2 Feb 2023 16:16:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m13so3616175plx.13;
        Thu, 02 Feb 2023 16:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKEGQCCzdWypotNm7WYkoeCFjmvtMpWtkZlxKvwri/A=;
        b=CO95XYz7/bB9i/4EE0M4Wwtg8kqrsw2ACX/54im0SGAa2JPI6mqMtPWobbrVqcXXq4
         WJRlB4eXZn0ZHRBir2rp395f/rsL9vmohFD5sDv/r61i3drJ/KT/DO9oDHaD2184r15Q
         fTm9U8+4iZepuHhSyQzL4I1siv2ReEVKipVI8vY6DsL+ZFle460mvCyURvkYwo2Si0mg
         Fw9haxp40zIthmx+qUavZv95PzVJW//QE/aPb1PaBYgt1a0LQjfXnWCftyKZykgJM7th
         /tRNfsOi4HduBifqMV7fwTTu7ZTJUdYcoxHR5dvMTAeIUZkKrdKDlMZBgXJ+8gsYsVk/
         xnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKEGQCCzdWypotNm7WYkoeCFjmvtMpWtkZlxKvwri/A=;
        b=bL8GdOEbjtIbYC8I37bhnGue9kbnO/e0imvXo8TirrcJUFpDmDGNHIfyrlY0ha+rI5
         gTq2apZQF+c9DwAW7rpV4PS1GDR4VH9WQaATljgHSxne2iJHKv/CW2P2SfBPFs/4nLmI
         ht3igVZe55Qi9EKAP+siEchvJ3FXvS2ccCZrtUTjz8Vo866pCCYsCe3rHS/40yWTDJDr
         WB+rPAjJh/iJOo/yU5NALM2qtzS4El12FRBZlAb6zJG/KVT96LLX3vTI0c0GEm9XLQb9
         tHKRaEh8LvPBlzR1WJkHT9flUAdNbdiSL3hRq2SAQ9j7VS3LaQIDWE3q5euJAPF5iAXu
         A1CA==
X-Gm-Message-State: AO0yUKULTVLQPuKmIlIPcwTYhP11kMVVbsBBA8tEa2NNvsMbjvujg1AB
        ggf5WbkWI53M7tlhxv2esN8=
X-Google-Smtp-Source: AK7set9qIGqskkAl3hlF4FDvZHxsYsaTHNCzvMhrg9Dnh0KQ7mPpKsMp3uAGfsg2glRl6aDBxbRbew==
X-Received: by 2002:a05:6a20:baa6:b0:b9:5ffe:3e6a with SMTP id fb38-20020a056a20baa600b000b95ffe3e6amr8364069pzb.1.1675383361736;
        Thu, 02 Feb 2023 16:16:01 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001943d58268csm258952plb.55.2023.02.02.16.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:16:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 14:15:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 06/19] blk-cgroup: pin the gendisk in struct blkcg_gq
Message-ID: <Y9xSPzSO9BMEpMQE@slm.duckdns.org>
References: <20230201134123.2656505-1-hch@lst.de>
 <20230201134123.2656505-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134123.2656505-7-hch@lst.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 01, 2023 at 02:41:10PM +0100, Christoph Hellwig wrote:
> Currently each blkcg_gq holds a request_queue reference, which is what
> is used in the policies.  But a lot of these interfaces will move over to
> use a gendisk, so store a disk in struct blkcg_gq and hold a reference to
> it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

For 05 - 06:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
