Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B75832E9
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiG0THP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiG0TGw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:06:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328E52E67;
        Wed, 27 Jul 2022 11:39:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g12so16867908pfb.3;
        Wed, 27 Jul 2022 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=LxG2FPTZCfHZ0sPfmM9/b7EFUr5JHWO+k7kdRXVsfOc=;
        b=PTpX8+xkC2yMfa6i3yo6jvZd+mQNhuldMSAWitMJGvEb5Z52tzlK6rJAHrUBcjNQgO
         i+CEuOqFKUv/qWk0eJXUPvjQ41KFNAPoDPlyEkhQMk4iEQ/JfzCV9ofHqK+RhAE+Rswo
         +ZLzYlYbpZB4yahuogO0iJQ+6tFePo1KsjqdiIalUyaaTa87I8TSXOErnoUYq0iCyE+g
         bR0msdKIRINYTAX2lTvf9LowGmpvpeGEGIi2HNgxcwpxoc7JvFNKV3+igDEMXpE23jjm
         ay+4vQ7fFRyjq5FRca66dFIXTopSqeegODXFvBY3l35s3h1ThJ/3jbiqcQcoZQz/X13d
         zFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=LxG2FPTZCfHZ0sPfmM9/b7EFUr5JHWO+k7kdRXVsfOc=;
        b=58YOPsyHYFvT+p+Dg71xhazjWkVwPwMLvcRkfBIBjNcbXYEBbbzx4v8kdsRYfcm6fj
         izTY4zM0ZJTTZ35yhbPAY9q7H3OaerMHgl2x+de441+v+RHR2H7csU7Ie9Zkn5BLhBJr
         VpmVZhycFlgxYwN63Tp1BwMGfTb8Gh3NIO27ztQVHBNSAJkYDTqljZbN8w9NHkAssi5I
         8zwUfe0wB8T7zSqeeZBMrNS8wgQGXzUg+X48YGlDT0IjnOW2EX65G26M6uowJzjqjhoc
         JpHs7+cJxq/06UjlNk/tInbX13QF5AcbJRYwcwyl/Llz8qSRmWNrbLXXfmMy/OX0BSav
         +xhw==
X-Gm-Message-State: AJIora/BTWYmjKnO2Hv5604aNTH22SDoNPz9F57BI1Ha0mFYDJzVGTnl
        yV5OIti5lFOUcy4uDIaYbw0=
X-Google-Smtp-Source: AGRyM1si4vls2M9LYH2xniRvYccffT8UUtBWGlMVILFMGLI8nni9rJLOf3Q6Y3jQYh4wEdH2RfwgtA==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr23467240pfi.44.1658947180316;
        Wed, 27 Jul 2022 11:39:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79416000000b005289fad1bbesm14636134pfo.94.2022.07.27.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:39:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 08:39:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 5/8] blk-throttle: use 'READ/WRITE' instead of
 '0/1'
Message-ID: <YuGGal0NYDkWJDro@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701093441.885741-6-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 01, 2022 at 05:34:38PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Make the code easier to read, like everywhere else.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
