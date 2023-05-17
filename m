Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04607071C0
	for <lists+cgroups@lfdr.de>; Wed, 17 May 2023 21:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEQTOu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 May 2023 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEQTOo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 May 2023 15:14:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E89DC48
        for <cgroups@vger.kernel.org>; Wed, 17 May 2023 12:14:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2534d7abe1bso516279a91.0
        for <cgroups@vger.kernel.org>; Wed, 17 May 2023 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350865; x=1686942865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Dlq/LhLdjBBa7rEoCSYP9M1ozuA1zyVPiangWQIFMI=;
        b=eIEE4i1XP1pkhSnVGQGWgRG8pI2jWOJ+cKID0bS4SWjSUNZSszxmLvKlYs83DOtNvF
         euc4WHz7O5H4eJswSX2r5tdLaLH69xWiwS8HTiIeB29IE9ymKTPasc6OezkZ8HLw3gkU
         O+NPk9Cn9iplJ8RJdF7qBi4aBY7UTxCuj4pMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350865; x=1686942865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Dlq/LhLdjBBa7rEoCSYP9M1ozuA1zyVPiangWQIFMI=;
        b=Rk7nGdLfAwm58Gy4ZPllJvT+a4vl8Y+O6SxkCvRo2c1681CCrz3DzhNYD8aYkNJM6g
         9SOrR7cmKr7HPoeYVphaJ8fUkS6X9gE04yEdxMay+EuCZOfV7eygfDAryniFsRvYLKqS
         u1L5xPTHGXi/+Gwmb3cysu2yx2moIbuGPGUnhi0G0kSCuBsNWMUfHHyadisLKNZZQNuQ
         RT4uYbROctaxdR/qohKpPZiO5vMbAiyWc9lHi0ptnzY1nXlteJI/YCDCK1c6lU3kork+
         VQuDA+hSSE/BHK5CAizqZb4LFtOAM8PZ3Rz0REvS959xhHf1PWoBYg7fcUcyyVa+QDXH
         54tQ==
X-Gm-Message-State: AC+VfDyjUmjAygIw9+Z9ai3Xxa90uGuwTu/Z2QNVwaX5ZDocech2vY0s
        bPjJbYZ/ky9dbZtbBM9m53dJ3A==
X-Google-Smtp-Source: ACHHUZ5r2i4mLMI3xIicT2J4MajYzfFC1hE8hQL6/UmcB88TIbPCyBR2eUzHiVUd+FeilmvLK0PLmQ==
X-Received: by 2002:a17:90b:186:b0:250:bb6:47ed with SMTP id t6-20020a17090b018600b002500bb647edmr659228pjs.33.1684350865131;
        Wed, 17 May 2023 12:14:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090ae61300b002500df72713sm1996216pjy.7.2023.05.17.12.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:14:24 -0700 (PDT)
Date:   Wed, 17 May 2023 12:14:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-hardening@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Replace all non-returning strlcpy with strscpy
Message-ID: <202305171214.C6B93E6A5@keescook>
References: <20230517144910.1521547-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517144910.1521547-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 17, 2023 at 02:49:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
