Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52A722FF3
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFETnA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 15:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFETm6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 15:42:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04FF3
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 12:42:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-65131e85be4so5200472b3a.1
        for <cgroups@vger.kernel.org>; Mon, 05 Jun 2023 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685994177; x=1688586177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Q8kSKP9++RgTXV8bTvJUl35GTdFE0i1aFw7qo8YRcA=;
        b=st9XK94tNgN4BG9lXJHA34tKteBoTDSg3G12r3RGCadsgXM31vIpI+8D93lfZVOfEo
         zpcP3cw3krv/31bKyMPvY+CYuoz1XuIqjtvJIYNuzQWxdSld2iPSi896/mzbnoAjgZSu
         lXGzC+oMLNNihl3LP0sobt+LQIebd40GxamN7HpseTr5okTdA4gyOKTjhbexmdaVLd2x
         nQYnWnOjVQwjNrZ2f4w6n1YPwm2EmAagNkajnVHIrSYWHejRmzEkUDDkNz1PSUIzfcGh
         IhPtVlbr0rzBlrD6DOMd0gtDdZ69uJcd7nXuYtkgtRkbihgY9ueV+cj+FBNQjCaSJL00
         /vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994177; x=1688586177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q8kSKP9++RgTXV8bTvJUl35GTdFE0i1aFw7qo8YRcA=;
        b=DiqUsC2EKOBpzBY+H936+NS+PvBuaz2f4CB8fvhPFAJzKKgjslWPhShVdDnd/1Mwga
         sypZyZ2hUWo0nBEAwXVTKMKH6aWJX+peYRqROpGHtd7F5R8HlrT7fVbIkmlQiK/ip2zz
         05rkKd22X8hzVvPgIsOYICNdyvgRG2dZWMnyogs54TQjQer8UROwFXfYPfsjbQYzAVIL
         HaqxZdIYtXxSQHoQSbLRGFAelaKhR7C5jYuP9cYZX1GeYKXUbmcYLVawjGkSCWJXem1L
         vDb6xJAOfEgM1ELUuUtUhlCm6VdCaUOARvgPiofDOP858m/S6IFA+llvabQgEJF5Eihg
         ZuDQ==
X-Gm-Message-State: AC+VfDzRg/VifwSmTy/v8tHADvvUIxx2GIz4ZCt3+ySM4Q8H9NZXKjfB
        +MMdmmZNGIyA9T/KR1FCIO13QFngMB8=
X-Google-Smtp-Source: ACHHUZ78hapDOX4uZou8juWZKpcXtV8j6mN70udVpLzi2NRQSfSq4qU0iFUMUxWwIqdiDWpzL51jqg==
X-Received: by 2002:a05:6a00:1a12:b0:63e:6b8a:7975 with SMTP id g18-20020a056a001a1200b0063e6b8a7975mr789744pfv.9.1685994176506;
        Mon, 05 Jun 2023 12:42:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b318])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b00646ebc77b1fsm5575198pfo.75.2023.06.05.12.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:42:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 09:42:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Replace the css_set call with cgroup_get
Message-ID: <ZH46vtiFKHu_f7gv@slm.duckdns.org>
References: <20230602074346.333276-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602074346.333276-1-cuigaosheng1@huawei.com>
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

On Fri, Jun 02, 2023 at 03:43:46PM +0800, Gaosheng Cui wrote:
> We will release the refcnt of cgroup via cgroup_put, for example
> in the cgroup_lock_and_drain_offline function, so replace css_get
> with the cgroup_get function for better readability.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
