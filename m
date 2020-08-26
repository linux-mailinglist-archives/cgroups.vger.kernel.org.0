Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9F25313A
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgHZOZy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgHZOZo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 10:25:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC5C061574
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:25:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so779901qvw.1
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0MQzhYw1eFCZ4OasAAPt/4uM+WwEYftpqDc/VYHMtbk=;
        b=AEeeIKetXtIdWWb5SAUNf0CT75v612rlaNccc1LnuJpBb5OvgTvnreoT4A4OjAHh83
         2gkDSfW8afxE84LI039FqJeIhxV2oGZ4RnkHwrgT7gaJY5kFVxvgD7z3kcBB0nmwawYl
         CS15Jy0Be3rJh0nkvXUGExE957xE1b+7UhD8hCHGOAkgpPAPwOWMKzZ3o/gby8vQ+sfN
         wDB5+JA+w8e/Hdgudw8JPIy+J6slyE1vtbucRIPeRAxApuJujob6n7+1FX7GzcKFLkOs
         Chs9V5WR7ttQDJxLdP5QRuGU/ZbDFDC5QqvZOLj2rWLfNycVtJZza+7sI/jmL4cSLtEa
         UEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0MQzhYw1eFCZ4OasAAPt/4uM+WwEYftpqDc/VYHMtbk=;
        b=IzwXYByyMU2u/e7lguLJcXUmwVanpTLsl5gNH4hFs4dmY6rsKji3v0NLOwSYmM+hUb
         Ozv/1RzRd+fvL5GC7ML63OQ9eu2EMjkD6opMsCvfXjnlx4a2naKN7MJp7/zgB146D5e9
         M/cpsKWd/KdLPHOtZ1SzkPPnhhUoy+1VGlYW7EQTFIR/fg48noRxC7sMnCaTj4g0bW4s
         4E+UAaZ4irpD1F16bUl4ef3i02AIXjvuEvGAQ0CqyDxVJjaUWxmjIYePAQMiFrlXHlRN
         vf6tCZZmfCfKSKw150OFEb26Cfb+7p74i9zRaekAGeJPdvxPJUcZ/DTRQ4mEG4vdYYC7
         sXfw==
X-Gm-Message-State: AOAM533l5usP9XHt5z/i8w9zUzZLviIRg3M3L8m6ETZblQd0hHb9dWQe
        NUTrGj0Hon94SN7o5Hxkequ/jg==
X-Google-Smtp-Source: ABdhPJyT1CcTFQngIw1LDN+6nfpS4iP5F+zti+vFgyKwmJgBJWLjcNUPyeRDliUrfesVkOYVF2X/xA==
X-Received: by 2002:a0c:ea21:: with SMTP id t1mr14182769qvp.62.1598451942396;
        Wed, 26 Aug 2020 07:25:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:67b9])
        by smtp.gmail.com with ESMTPSA id a25sm2076443qtd.8.2020.08.26.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:25:41 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:24:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] proc: Optimise smaps for shmem entries
Message-ID: <20200826142427.GC988805@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-5-willy@infradead.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:46PM +0100, Matthew Wilcox (Oracle) wrote:
> Avoid bumping the refcount on pages when we're only interested in the
> swap entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
