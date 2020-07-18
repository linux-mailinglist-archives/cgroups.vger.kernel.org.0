Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55122499B
	for <lists+cgroups@lfdr.de>; Sat, 18 Jul 2020 09:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgGRHQz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Jul 2020 03:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRHQy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Jul 2020 03:16:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E0C0619D2
        for <cgroups@vger.kernel.org>; Sat, 18 Jul 2020 00:16:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so17782353wmj.2
        for <cgroups@vger.kernel.org>; Sat, 18 Jul 2020 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xHVnQvxmbGU9Ko0uL8p4tnJQ0J1CLCT6xz7M4Ccg8MQ=;
        b=oKdcHxt3cYiLH9F6JeaENxb3L0suuIESYrWnz4LMdoxe18XhXLj8d43wOtim0uIAme
         zPJVkdIlbZiiY72xPKODgFXZOO4UxfjZJ2SUbMkjOAAS6ptdt4+ntKvReVn4Z2SDdm2B
         3yVGvFT9fXvAbYkt5QRFUB2AstxiC87gcclw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xHVnQvxmbGU9Ko0uL8p4tnJQ0J1CLCT6xz7M4Ccg8MQ=;
        b=pRSgJ+AAGrD8TR91cenvh/sHEUPM1/xrCsiWwxqYV4t7hkG0Nvfj9v08E2rIHtM4Yp
         49mh22I++SzoKNHznNPk8AAj5D1TE3vIjdwPgDM70Y59/dGH0dKbJ9aEnkiyEfYShTR0
         6TLSxj5KYzycqkBRE2w6RZuwYbxCFwI3ysJBdiSElvKfxIKb14KoRxoFTgFiy+59oBdr
         GMiz4kjXAlloO9gMZOm5yQSvRX7yylhRRbWz+b0Pl3lyum15lr88T/NRTxRfEqsJko/2
         D8FBXLtpOem12+sF7UxS0MerWpsxInTCVXA0EbP/t7/nJDBbeFEiVmMEoS7Ico9ZOW6f
         E68Q==
X-Gm-Message-State: AOAM533WMuGtUAnfG/I98ReiXhETGbiTLa1nn22yTk0RbaXkEvfZijdG
        2AIm+NchF/MFxAE+isJMcbxYMw==
X-Google-Smtp-Source: ABdhPJwDu/WXFihY/rK4j6j/qIbeQLSuG278GwIf99LSLS+GmPXKjvZGiqEP3BMycjQA3h2sqx5d7A==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr12532502wmg.123.1595056613105;
        Sat, 18 Jul 2020 00:16:53 -0700 (PDT)
Received: from localhost ([195.68.125.34])
        by smtp.gmail.com with ESMTPSA id 59sm19792133wrj.37.2020.07.18.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 00:16:52 -0700 (PDT)
Date:   Sat, 18 Jul 2020 09:16:51 +0200
From:   Chris Down <chris@chrisdown.name>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] memcontrol: drop duplicate word and fix spello in
 <linux/memcontrol.h>
Message-ID: <20200718071651.GA467892@chrisdown.name>
References: <b04aa2e4-7c95-12f0-599d-43d07fb28134@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b04aa2e4-7c95-12f0-599d-43d07fb28134@infradead.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Randy Dunlap writes:
>From: Randy Dunlap <rdunlap@infradead.org>
>
>Drop the doubled word "for" in a comment.
>Fix spello of "incremented".
>
>Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>Cc: cgroups@vger.kernel.org
>Cc: linux-mm@kvack.org
>Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Chris Down <chris@chrisdown.name>
