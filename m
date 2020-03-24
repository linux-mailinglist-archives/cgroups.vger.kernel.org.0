Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F482190D2D
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCXMSA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 08:18:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37241 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgCXMSA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 08:18:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so18380196ljd.4
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2020 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1SPUCMMR/pnomJcGWLTMgKFX0vHSGUAZoz9GUYMTj4o=;
        b=tilrUvK9V7AIYx6emcjcWpLXFQEyHa+05bdQDIoIywZX2y3SMoEqBFiAybQqeaoQmH
         qCW38SL4fJ5VBAOb8iFlk///0sNWC25UhpYQQWKRgBijygrHu0xvBAtqsphh+EUTl/O2
         G/N7sSiUT0spzki5rmzIRfzFDkF3rhztgtSZFIbBY7oBrWXTwy66j+A3LVnCQDsi7qDk
         /Mt7MYFlctk0gdfk6O3vSL+Tj6CY4O0eXlyiZi2ju9Ktl4TK6O0hsWQBgPzPB8PW2grU
         HFeLO7sow8tEfwRFWJ+cSErDCMq4U85TpHZyFV3YvgQJyUfiAMty/XMOrODGeLxAgSoU
         xXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SPUCMMR/pnomJcGWLTMgKFX0vHSGUAZoz9GUYMTj4o=;
        b=R0fYE4BR9qDtEThdxnRalRPyD0iGhM8oqS4tR2WaJ8gxGGSkVSUxppH1UPb3GXfWbo
         L9eOB9VCaMXzKHcPBDBwYAp501xX+VD4GVTyNsXWQF6PHSFazLQc4AmQcHMm2mWeWkDu
         dNQ/v95Jfz26vViC3XNn135DkSmePmL2vN40CMRvejXABT6tHOwbYT1Vnr0VOfBZh8jG
         7ZhIh22G25OtN3yM98O6kTIqMnkQF+/ov62xKwbt6g2EMyOh4b5YUpZbQci1OdGGBt3O
         DpIszc1YsckJVscrsLUwDmh/oT1bziQnmNE5sb8eSsgvYDQ1qKBCU7gAGdMovTjg8+2H
         Tt3A==
X-Gm-Message-State: ANhLgQ2xfXzfE7bB5C9LHR+FeaOhxuYEM9OeEW0DjyEzHjJiSfCEnMPy
        yyEtMAIHkAZ2+y79Hb7EfU/dZg==
X-Google-Smtp-Source: ADFU+vv7lKNVww4QN95L6mxFqLdHghRsIBPHCaknhAn/jJAnLJ98SKxvbprs0oZ3hACQ1WILAjzmhw==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr17842543ljk.220.1585052278511;
        Tue, 24 Mar 2020 05:17:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f28sm2195911lfh.10.2020.03.24.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 05:17:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A56051012C3; Tue, 24 Mar 2020 15:17:58 +0300 (+03)
Date:   Tue, 24 Mar 2020 15:17:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, sean.j.christopherson@intel.com,
        thellstrom@vmware.com, guro@fb.com, shakeelb@google.com,
        chris@chrisdown.name, tj@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
Message-ID: <20200324121758.paxxthsi2f4hngfa@box>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585045916-27339-1-git-send-email-teawater@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 24, 2020 at 06:31:56PM +0800, Hui Zhu wrote:
> /sys/kernel/mm/transparent_hugepage/enabled is the only interface to
> control if the application can use THP in system level.

No. We have prctl(PR_SET_THP_DISABLE) too.

-- 
 Kirill A. Shutemov
