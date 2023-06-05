Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18572325E
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFEVix (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 17:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjFEViw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 17:38:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0852E9;
        Mon,  5 Jun 2023 14:38:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-655fce0f354so1411213b3a.0;
        Mon, 05 Jun 2023 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686001127; x=1688593127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pGqWwqQ5KPSrbDc5xd4FA01+FepvTerJM42ML5MoMQ=;
        b=nRyW0hhDZTfCvxSPTJDii7pUm7m0UfNlz52xzqH/Ya7UPueAxRK0Uou40EdrNBMiCi
         Hinczjj7Coajh3hhMGRNJ3S1eDX5Z5WXp9pYEhmMaUW7lkw4m1pxtt/z55sfYrbrD2Ri
         OJnVzn5PY2Q57bilmau5NsYtQDrqpQv0zLf1j37IHi16kXVsjnqYjgefqcdVh36KOek2
         kJDahFarnBOIVWPp3yRIR6n01M5dNBp80BNm0lU/nao1Jyh23f9v11y4GnV7dxbVwFwf
         dQ+isfC6B9v0YFzYwCbYbVvi/Pjqj7/6gg5H3PTWcMLQLmp64ro63sbtvZqv3IwbgsD6
         1wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001127; x=1688593127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pGqWwqQ5KPSrbDc5xd4FA01+FepvTerJM42ML5MoMQ=;
        b=I1RZWN2l+2g8Fp0mUX9pU860XFtnHcfW542DJCyoIq3+pOsASJTWL9XLV+SsVz8u1+
         ecn2TF2iGVRXnqt0G3EXixO56zF+5fa/lySZlop4uBg2YsgjSwfewBNjp8KfPMgjsOUd
         lLv3UhToT1M49Ti1QOiL8B9WYM/IMoL9agFXuUeVlrhVl6KMIdu8uSEkurjeF9f1lfPQ
         4dNy7Oh/tXXTXiyJWkuix5TK3Kvdk+xznZxfE2a+EYrVN02gHGZciWZAq1Z9i+YBVKQ6
         ZEHtn71yTCuzectzky67NCHYlOcKWYfKrRba5a3b3j193nLRY6trqs5hbSMarCwUFV46
         pMVA==
X-Gm-Message-State: AC+VfDyecTAIV+uqLx8wFJOXMfr8raDZpV9M55wwg69+KXJUtElNkyKO
        UBc5kemvu4vXLudKrtICbImnXBjNLlg=
X-Google-Smtp-Source: ACHHUZ6L1JAW58GJhdC+N9W5B/DWtaBRfBzGAlkSy3IEI8oK19vlJ4Cf6OYYlDILpVorpYRjoqOY+w==
X-Received: by 2002:a05:6a20:8e12:b0:100:b715:8ab2 with SMTP id y18-20020a056a208e1200b00100b7158ab2mr267146pzj.46.1686001126977;
        Mon, 05 Jun 2023 14:38:46 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id y2-20020a62b502000000b0064c98c87384sm5579508pfe.44.2023.06.05.14.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 14:38:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 11:38:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zou Cao <zoucaox@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, brauner@kernel.org,
        Zou Cao <zoucao@kuaishou.com>
Subject: Re: [PATCH] cgroup: fixed the cset refcnt leak when fork() failed
Message-ID: <ZH5V5S5InM6b1iK7@slm.duckdns.org>
References: <20230605130444.1421-1-zoucao@kuaishou.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605130444.1421-1-zoucao@kuaishou.com>
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

On Mon, Jun 05, 2023 at 09:04:44PM +0800, Zou Cao wrote:
> TeamID: B1486294
> 
> when fork, cset will be increased by commit "ef2c41cf38a7", the refcnt will
> be decrease by child exit, but when failed in fork(), this refcnt will
> be lost decrease in cgroup_cancel_fork as follow:
> 
> copy_process
>      |
> cgroup_can_fork    //  increase the css refcount
>   ......
>   spin_lock_irq(&css_set_lock);
>   cset = task_css_setcurrent);
>   get_css_set(cset);
>   spin_unlock_irq&css_set_lock);
>   ......
>      |
> goto cgroup_cancel_fork    // if failed in  copy_process
>      |
> cgroup_cancel_fork  // lost the decrease refcount if flag not CLONE_INTO_CGROUP
> 
> Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
> Signed-off-by: Zou Cao <zoucao@kuaishou.com>

Is this the same bug fixed by the following commit?

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?h=for-6.4-fixes&id=2bd110339288c18823dcace602b63b0d8627e520

Thanks.

-- 
tejun
