Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361D1738F60
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjFUTAY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUTAX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 15:00:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F85F10F6;
        Wed, 21 Jun 2023 12:00:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77e250985b5so201622339f.3;
        Wed, 21 Jun 2023 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374019; x=1689966019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkWc31QshB/LMbmy/U7IMxynfJvynM10dLnhD7VuGr0=;
        b=hn4FLYsX9n/TfMXBqz5KHMRnQQPS9PO99wDb/S2cBdELnBET33B1yuvsV2X+R132Rl
         kS5U4v/nsxmTZBpS1ZlzPJ/V4eRwgZJ6gtt6FgjrgmdEcu5e9Qvlqt6p4E+sD6SXx0Hb
         Ds+wqYyxr7boTwr92KQQhIIlbp5oL4p4DAhTWGbrxkxfCUA0k/MVgftuJwyg0Xym2EBA
         XuLptxf8aH2v70DL98tpcQPRtfWoiHvEAkR0cAxTVvYlAVtkmhotPvZgAx2yPksVa9Nf
         zcC07SWEstZU5sQwiXngm8kNsVhHn0yBSMA4riraUtHDnbFn4Vfofe70985kCFS4Nw9g
         jr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374019; x=1689966019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkWc31QshB/LMbmy/U7IMxynfJvynM10dLnhD7VuGr0=;
        b=A+z5NUgLXdS3J/rzrpDDsCfTpCPKoUD0zLOmaRfQ7PTagpVHfd7HZoism9PFYQFZt/
         feLX5azheH7WimGfDWkowStKpKTmj8n6xnqSHyjmbTB0q0IlBCWLkc3gdTwuD/gtQIwL
         vwfRgsFlHZSl4VUod3iGzbi9oKQjgEhkmEg2ZF40FdznGxVmEVNPWlBaUxB5S/czZwNv
         TcjppyME5jJFPAfqj1kxyW9bvN1n4Iq2zxjPoncyypISOlF9P4RfYcARdqYATi7cjRG1
         gPsc8FqsbXexYFH3mIc/3JwrkW3i47xL5zXquGFXtT65D19PX3DxO8VUyMYl8FqoK2lk
         aSmA==
X-Gm-Message-State: AC+VfDwJCRDdLzZYSnHYbuPawW6b8YfaNfqPk/Z6qfAH4RQntsSXGiEI
        0ek6bPYGDC4pfP8vZWE+kMM=
X-Google-Smtp-Source: ACHHUZ4C+WZLOdIkd4iXADxJa2TEfGroDORO8/2DKhupg1HNaJ8ZeYueLixsYugeAi8pjGSpYUpwVg==
X-Received: by 2002:a6b:f61a:0:b0:77e:288d:f3c1 with SMTP id n26-20020a6bf61a000000b0077e288df3c1mr12153678ioh.6.1687374018812;
        Wed, 21 Jun 2023 12:00:18 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id g12-20020a05663811cc00b0040fbb3bd38csm1484826jas.145.2023.06.21.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:00:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 09:00:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove obsolete comment on cgroup_on_dfl()
Message-ID: <ZJNIwAJDibFthvwp@slm.duckdns.org>
References: <20230617074809.1929778-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617074809.1929778-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 17, 2023 at 03:48:09PM +0800, Miaohe Lin wrote:
> The debug feature is supported since commit 8cc38fa7fa31 ("cgroup: make
> debug an implicit controller on cgroup2"), update corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.5.

thanks.

-- 
tejun
