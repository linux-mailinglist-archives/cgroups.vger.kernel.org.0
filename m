Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237CE178BAB
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 08:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCDHrZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 02:47:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34923 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgCDHrY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 02:47:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id a12so898086ljj.2
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2020 23:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=90yR+U0yyx88muPof9ELq5RmjD8lTcfReEz4WNGCuAs=;
        b=J+9ttkkL3U2tfSixpLp40ZevGJY6w7+oKgo008s4LmmMoFaX+aoXETJoaT3XHhKDxJ
         O99zq+b1QV2fGPwaPM77i9ENNzpQtrCIRt5R21GLOLzITiMTWACJMz8qhybe6oOkE8up
         TbA8azSnt3BipfJBXIH3cuIX5SlSCjH2aCtokjd4WKtCcXzp4Lp7lexqYWRUTZ9T3syY
         lVJ7kMvEepib4Y7C55YIt9sc7BcTRMqQnwgBEkyT+HQIBDXBZj427rqWevhU/LgSowOt
         P4Ou049Cmky7WSmt5pj8TZP7cNAKUECUqOKtPEPKf8f1NgZn3PuZsvxevrcgxVbZGCJ/
         cTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90yR+U0yyx88muPof9ELq5RmjD8lTcfReEz4WNGCuAs=;
        b=exbwURyOZzTB6lUho0US/n1TIxDiwQLOKMRv8v61+xjYfeQ3oPdxhfpOgdmWSyB4y8
         Gj+jVy1LTjRMOA/rrmkXouD2++yake63ywFxfFD0GmQojBWDSAap2G2baHUeDUcXPnS7
         iRhfkaUudJ7ro9yFaMDzl0K8cSsOuudpGLkyRr1gXQCzq/XqUPtJwyxbqqjIfLsSCcJL
         hxu0TswWjM3Va1Fsirt0T8pE9ggl9WDI+lBh2x10IC6O/leGM+RkFZEW/gjwtpDx0BHs
         vz+Y5UrasyFdlz9K89++vZXv2a67ULQax4cetOaiSG+0oyJSWQ0uzDlG2j6/2p15zpH6
         +hlw==
X-Gm-Message-State: ANhLgQ08HaenWuLMIFGKpe0+yOKqVxXxR/2maPz53ndZKg0qhzSnXVoD
        jJANLTZF5SI2nMWoUwoHINNxVg==
X-Google-Smtp-Source: ADFU+vvthg21d+IvRKw0r2uGiQyTdS6vwB709S/BjS55tayWxFK8wV01Tvm9aaXShoVjxV5AGPZO8A==
X-Received: by 2002:a2e:8754:: with SMTP id q20mr832943ljj.158.1583308041359;
        Tue, 03 Mar 2020 23:47:21 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t3sm232731lfp.81.2020.03.03.23.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 23:47:20 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A5062100EAB; Wed,  4 Mar 2020 10:47:19 +0300 (+03)
Date:   Wed, 4 Mar 2020 10:47:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v9 04/20] mm/thp: move lru_add_page_tail func to
 huge_memory.c
Message-ID: <20200304074719.e6unbgdop2r3jhk2@box>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-5-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583146830-169516-5-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 02, 2020 at 07:00:14PM +0800, Alex Shi wrote:
> The func is only used in huge_memory.c, defining it in other file with a
> CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.
> 
> Let's move it close user.

I don't think it's strong enough justification. I would rather keep all
lru helpers in one place.

-- 
 Kirill A. Shutemov
