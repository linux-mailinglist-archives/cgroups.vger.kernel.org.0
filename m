Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2033B9A1C
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 02:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhGBAei (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 20:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbhGBAei (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 20:34:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E763C061762;
        Thu,  1 Jul 2021 17:32:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t9so7901217pgn.4;
        Thu, 01 Jul 2021 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7GtzayBonC8NXc3VVE0on7/iur23UaGBI7PatPPRKM=;
        b=H/u4c/hymNgAID7Wp67NBhcBAjGZwLzZ7zRqFx+h8z2wsf38WglwFA0aWj8YA4tf7X
         6hqu5BrC0s+b/4hFo4R7JjVJD/HUBl3u+qa4pJej4Gv+7N9OWafAjHyFxvz3JSmchGDe
         ggfzuBlxzNCGTTntNZcxSLVJWmhr67FXIfBRTe9eZUro1ppaML51amNUeDKX9nm032/w
         SjQJYQIhJ7oN1bMgepUhuQp5H9CiqP0fs7brc0wCE2xbgcIcCnj6QQhOnB109dEyRkkR
         FOybLuD9UbnD1NhEzoNPfNoLCrTymMu5VSIVHukjPMdaUwFbMFyKraJCvO7CbMDG6V+Y
         hPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=S7GtzayBonC8NXc3VVE0on7/iur23UaGBI7PatPPRKM=;
        b=KXRUqz2ba3E0mbWjD5U+gmwYPv//ZhBG1cQpNUsOVVugAcW1BEjXeDb8KckCRZkEEa
         hIaGR4q5cY1KE3/1Z3uevFral5zNqpY57UBQgqFU8zX16HUkDELpz8inVzeIHA0BF77w
         dSDMJneFkaoC4TcPERG9rZOW57uQlRS6hgoPDUThwPzAFDN8lWu6/ad+1i67mNo/RkZy
         6Rwbtiqhs57k0/j7g7oiv6dBnrrpftusx9cJWv83ghsjpWpByIvQFMEX37QyB/0AHIdE
         3S1SrTUtpZr65LrUSIuByj7v3Lt332MaZqvHVUmdcNDATdrMsYm1PWGsFUTMwNIsa/1n
         BiMQ==
X-Gm-Message-State: AOAM533r8ZRxhSmSlVhDf6li6oQWLCpj3BOstbwfRFeWA1tbu3H41Mwm
        fDc7UIn/Feb/qurKgRE2XjdIJaDAsEE6HQ==
X-Google-Smtp-Source: ABdhPJyG3i7g+MTD9q8cjQy7jmmfYmWjJOYjCg+fnKiP3dOcxrerO9ip8g3LOEPd8sXKm2GgFL+8Pw==
X-Received: by 2002:aa7:8681:0:b029:304:3432:ba2a with SMTP id d1-20020aa786810000b02903043432ba2amr2658060pfo.40.1625185925548;
        Thu, 01 Jul 2021 17:32:05 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id gk20sm783508pjb.17.2021.07.01.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 17:32:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Jul 2021 14:32:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] cgroup changes for v5.14-rc1
Message-ID: <YN5egtsVvp3xIqCl@mtj.duckdns.org>
References: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
 <CAHk-=wgcyjLGcoRho5iw7b3Yx+R05rXwyJmP_LhOqsHgjiZugQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcyjLGcoRho5iw7b3Yx+R05rXwyJmP_LhOqsHgjiZugQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jul 01, 2021 at 05:25:59PM -0700, Linus Torvalds wrote:
> On Thu, Jul 1, 2021 at 1:55 PM Tejun Heo <tj@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14
> 
> I've pulled it, but let me vent about this history a bit.
> 
> Look at commit c2a11971549b ("Merge branch 'for-5.13-fixes' into for-5.14").
> 
> Now tell me how that commit explains why it exists.
> 
> Merge commits need commit messages too.
> 
> In particular, they need commit messages that *explain* why they exist
> in the first place, not just a one-liner that says what it does (and
> does so badly at that).

for-5.13-fixes had comment updates across the file and I pulled them into
for-5.14 to avoid trivial context conflicts down the line. Yeah, I should
have commented on the rationale. Will add explanations from now on.

Thanks.

-- 
tejun
