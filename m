Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D0D5298A2
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 06:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiEQESu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 00:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiEQESs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 00:18:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0B130564;
        Mon, 16 May 2022 21:18:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1195152pjq.2;
        Mon, 16 May 2022 21:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xf0kL1+XuM7P75yKi5gORiIETclggCfCwYHC9O/komI=;
        b=dGfNWhVuygx3lxtV8htZeLUSrHPK74n/4zuspp12F3Ej9aM1jDUfauaeUEwwflxDd1
         cVfzVfCyiXz6HsQHbH3uqnCyETM0yGfbehqOfgpZjYrkRamWiLEAjUjU/N6XUCAGMwTg
         e46ZvTeAHHkSFMQ3fJwFLWMW7AwEaAJJGbRZdKmJB+TENAhuzW3836VbZX0SLgkxvjQw
         dwvW5/dOX/UeN8Rz/zat7MKgFD1Z3C5YP+RjOmCefWIW+Hfi05TAW6USx06+pNFf9TEl
         SSiNgdWmlpUg386INY5i3wS7xQT1lUyDL2rOcTJJurcX6Q7JtYvwt6mfdCqGBBFKud9e
         euTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xf0kL1+XuM7P75yKi5gORiIETclggCfCwYHC9O/komI=;
        b=cB09Zbb6zVriwEbMMN5ELDwdNY9RRaETuDQ7hT2MCKA6HAlKwhHv6Bmm3LivHCP7N1
         BghGuUG7XznExHpKpbaCnus+3DCIJKIj6i0vADG/nmkz0iLx+LqvwEo2w+pF2I0CaU1H
         cKpv2K18BR2Eidt/RddM6Hm11QYoL+Y8MeBJrOc9OP3Xgyn75jLrPYggmPNufEFaOV/S
         xgT5Zjg9p5rEh6SJl6ZgjXfNRVAxaEcXQDzGilJpg0MSF0HFSbbH+0FVtRUpYDNrLz/z
         Ikyd5YC5IqdTq6oEHHcy3PFeLYRbN4ybS6qKCa4H0MkF7LqNLRuWMYuPfp3qVRi7onNJ
         ECVg==
X-Gm-Message-State: AOAM531FZpMzu23+P4IgUwZ2akRypBkZUr/IOOZ2nsNw36YE/GtuElkd
        Vlfh3P1AmfmcOlvIkBlYPGo=
X-Google-Smtp-Source: ABdhPJwgsWcgQL4lPVuAZ8ixm4JN/ImNMVWhzcjD3C0B9Ty9Fqsv3rJBudKOk83QYc/aHonkST0aAQ==
X-Received: by 2002:a17:90a:9b0d:b0:1dc:e81d:6c18 with SMTP id f13-20020a17090a9b0d00b001dce81d6c18mr23151877pjp.72.1652761126747;
        Mon, 16 May 2022 21:18:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902c2c100b0015e8d4eb28csm7790789pla.214.2022.05.16.21.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 21:18:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 18:18:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Zhang Wensheng <zhangwensheng5@huawei.com>,
        "ming.lei@redhat.com >> Ming Lei" <ming.lei@redhat.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH -next] block: fix io hung of setting throttle limit
 frequently
Message-ID: <YoMiJIUehq1UyzgQ@slm.duckdns.org>
References: <20220516014429.33723-1-zhangwensheng5@huawei.com>
 <YoKmCOAzwzw3Lz7g@slm.duckdns.org>
 <ca251645-8d52-7a93-6ac2-579d97922a9e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca251645-8d52-7a93-6ac2-579d97922a9e@huawei.com>
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

On Tue, May 17, 2022 at 11:12:28AM +0800, yukuai (C) wrote:
> Ming added a condition in tg_with_in_bps_limit():
> -       if (bps_limit == U64_MAX) {
> +       /* no need to throttle if this bio's bytes have been accounted */
> +       if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
> 
> Which will let the first throttled bio to be issued immediately once
> the config if updated.
> 
> Do you think this behaviour is OK? If so, we can do the same for
> tg_with_in_iops_limit.

So, the current behavior is that if the user is being silly, it will get
slower and slower. The new behavior would be that if the user is being
silly, it can issue IOs faster and faster, which creates a perverse
incentive to be silly.

Probably the right thing to do is probably something like translating the
existing budget in light of the new configuration so that config change
neither gives or takes away the budget which has already accumulated. That
said, are you guys seeing this becoming an issue in practice?

Thanks.

-- 
tejun
