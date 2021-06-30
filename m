Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E773B84F0
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhF3OV2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhF3OV1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 10:21:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85588C061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 07:18:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso1480345pjp.2
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHOfskBMscOWo8oHAVTd3r5USS+PMqdTaB3S184K0g8=;
        b=e2VD0gvbg5EBocbr4RU9lsaAxSQrpxjSqnQLMdmbaOOHyqVE2uU5mou9nL+823hYH6
         TUGJ1CgzW8/g2z/dk1giU+QC8JZ2yupy7hxiBSnoU5fBIKs4xcEkjAYhqrde+j6QFyuD
         6TkgwSpSkeCvDSjzz/Cg3X7pgZ0cS8NaaBgUyV6dFuwtHQC0lCdm5s8EKQ3yy8gZZByJ
         g59bRWim7rzZ3YaZb7Nngrrmw4AFQsDuAoM2gI7TrrECRwODxzPc3rumwgPKWrzaHeIQ
         ZNvI0crvydaDuZajEhHf6yf4TjiTQkCb862LKp2G24T5RRTUuC3ARVWli0Bw9cxyJ6jx
         f9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHOfskBMscOWo8oHAVTd3r5USS+PMqdTaB3S184K0g8=;
        b=nx9WUHT3kmIGzGk6f4suqU35RhSaWwnaPrXGBBjGXeVQBhFjX8pcoLlGk3De7YEcEe
         TPTfcwHi34ayp+twPh+0tPw/Id8S2C7PQSjuFBRspiuDgvNUvfTICBUV42NfBybbtMVN
         m0E86e/WCA6PpXS8kt8KlkybkDT+iMIDh5WzbxhGOi4LrgvFJfFFwi64e7i8/Cfx5/F1
         Svfw/hiQ1wtLbvY+0dvHDb4mehfwww15ITufGa/O/oXbtWscj+9ccLk4VDM2IcPPvvqu
         wGSKh7HlsAwxeQA50M62xXklCLBw3BhT5eYV/6RqzhuzdiX2on8vjz4zM+gUR6GuXx7/
         ysJg==
X-Gm-Message-State: AOAM530ATBSWm0UIgHkHzbu+lt0LuoYRppcLkMgKgxmEURXB5Q/IrJsx
        ELsdxrTN/edNucZXmD9fEOj/Iw==
X-Google-Smtp-Source: ABdhPJyrw9yf9NzVNChz7THxqpByU0wB92+pGT7eH4JP3+jIVIRQqG3+v2Y1lNIxjRqrIudN0krQJQ==
X-Received: by 2002:a17:902:e54d:b029:127:9cd2:ec3f with SMTP id n13-20020a170902e54db02901279cd2ec3fmr30423529plf.44.1625062731020;
        Wed, 30 Jun 2021 07:18:51 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:14ba])
        by smtp.gmail.com with ESMTPSA id u13sm23208169pga.64.2021.06.30.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:18:50 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:18:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 03/18] mm/memcg: Use the node id in
 mem_cgroup_update_tree()
Message-ID: <YNx9R1lZe7ugwS4n@cmpxchg.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-4-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:19AM +0100, Matthew Wilcox (Oracle) wrote:
> By using the node id in mem_cgroup_update_tree(), we can delete
> soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
> bytes of kernel text on my config.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
