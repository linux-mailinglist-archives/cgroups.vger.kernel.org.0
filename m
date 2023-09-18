Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E7F7A5136
	for <lists+cgroups@lfdr.de>; Mon, 18 Sep 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjIRRrX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Sep 2023 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjIRRrX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Sep 2023 13:47:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F8DB;
        Mon, 18 Sep 2023 10:47:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso3685088b3a.0;
        Mon, 18 Sep 2023 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695059236; x=1695664036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPhgdY/CmzoobfbrK6uZSQDRjVzzTjVIIZJoiShDRQ8=;
        b=WHBZpebE02E1wErRLGRIM+C4JllVNMWT4idpU3lhC8boizv/+y7d69c/VQYQBmzuY8
         +f7d08xMWcRZqU6rSAZU0wFXD60ePk0fM17Q+8lTdE1U5E51DpcrBtstKc595sHz+Dxt
         4Cge0Eqwp1MOsEpU3OXuUZDY5SOA/RkAT7o46Qp3ZqK1J/mzGBqpFKsoMzaDWeeOjv9/
         Be6gs1MkquHVz9jqY2/cJP2gw1b9kCFfDeOiIOkys0Yb48D66GBTC9F63xfCw13acsyo
         HMbEGK9TZ8Bf9TXOVREVylWgMbLFiaW+SIl+oMfo8hX5A8hW4M0HXibxq9FvxKmESAXA
         pdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695059236; x=1695664036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPhgdY/CmzoobfbrK6uZSQDRjVzzTjVIIZJoiShDRQ8=;
        b=jZoiylMocx9oUyG9Xb5WAUBC0hAAkBYBLaXxMVcll8EeoU4/y2w007im3G+z9Q+Y7I
         /VinmAc7CW/d+1PA97moBXkY+a4WtNUVywYzJM1uWIzT2WmQYphqNVT++ETw4W0eI620
         bM7seJagh74grxI4yv5/KahEOliwx305Xt23t4R1DGOYZIr6mTm+CjCo0xlxHkjolYzG
         jXVyLKq05YGBJjYdF/1oa5NpmCiP6x9aI20D7H3gL136uueREgi8aYrV3SStjYPV8ZR2
         KBV/enMl+6UwVJXWwxorYOtufM1RjBjGJ6LsS3zjFjGugqpm9t/Y8piOdjNgCh+Q96Cp
         apfw==
X-Gm-Message-State: AOJu0Yw6gYRe8EbjIOiofudDkNG0qyWC7V7EVyys+c+0mfuF2P+HmWGl
        jpCQ82rYzpqKACOkQaOMgDA=
X-Google-Smtp-Source: AGHT+IGVWQ9PAvRsXcaKlGPT0ctxW34Rf6EtnoTjsQzYOhIQS5GyQvCg9P6c2dKeO8cMUDwnfd8MmA==
X-Received: by 2002:a05:6a00:1487:b0:68b:e18f:2eb7 with SMTP id v7-20020a056a00148700b0068be18f2eb7mr9844162pfu.1.1695059235679;
        Mon, 18 Sep 2023 10:47:15 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7910f000000b00682a61fa525sm7622082pfh.91.2023.09.18.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 10:47:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 07:47:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, lcapitulino@gmail.com,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATH v2] cgroup: add cgroup_favordynmods= command-line option
Message-ID: <ZQiNIWQe7spOwjil@slm.duckdns.org>
References: <20230906005712.66461-1-luizcap@amazon.com>
 <29bdb453-c6e3-a047-1f27-e9656da92301@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29bdb453-c6e3-a047-1f27-e9656da92301@amazon.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 18, 2023 at 10:01:13AM -0400, Luiz Capitulino wrote:
> 
> 
> On 2023-09-05 20:57, Luiz Capitulino wrote:
> > We have a need of using favordynmods with cgroup v1, which doesn't support
> > changing mount flags during remount. Enabling CONFIG_FAVOR_DYNMODS at
> > build-time is not an option because we want to be able to selectively
> > enable it for certain systems.
> > 
> > This commit addresses this by introducing the cgroup_favordynmods=
> > command-line option. This option works for both cgroup v1 and v2 and
> > also allows for disabling favorynmods when the kernel built with
> > CONFIG_FAVOR_DYNMODS=y.
> > 
> > Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
> 
> Ping?

Michal raised some valid concerns. I don't really mind that it's not great
on the edges tho. Michal, what do you think?

Thanks.

-- 
tejun
