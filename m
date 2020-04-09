Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701661A36F9
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgDIPYU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 11:24:20 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37267 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgDIPYU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 11:24:20 -0400
Received: by mail-wm1-f48.google.com with SMTP id z6so155801wml.2
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2020 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y6Uasohp5UNg9y1/Yu3p5ekTJRoqFqD2BtsV4x2pR0I=;
        b=tJwqs1khMdMVGEMNLiUcBFTGDIqguzpIzMsPiVfg5EgAVW+WBMfkKjP9HYUIcxsifN
         nsXbYQC6zM5zGRKyPS3TB+E17ssyTm5obRD54tsO2bPMp28xtlfhLAghjMBTOJqJgEcf
         piGAgYTIBDk1+nNYj+lZh0bX/P4UwSupgOjn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y6Uasohp5UNg9y1/Yu3p5ekTJRoqFqD2BtsV4x2pR0I=;
        b=ldOPkCTRvkF/y4NWpff8MOpYuHcKSrm8VwsGZPlwqYJCXnsbTqXRHF/ZyG1TlQOId+
         2i/bXXa/TCXN/ItSDGxh/JIZvInZZsAI8+u/JPoEquO14sCSLCcj3kDsn4R4Ez4Dinyx
         kuxhnbHM1OWj/h8n/nRIPdbMwi/cAjkFhHs8YPxwCHEXvlLXmcGLCb49r8xSoeTglePH
         1LlEXh37y6YbGA7zwUseB/KHawltWQU2fPxiyxyTbzULo7owEe7IlB857YijbPGtZgbw
         4g9PN4zif/TeMDYHvzG6tu8jnTpuePCh3ib9LrpOI+VV76eGcGb1yP5HuGzKg8oib0Qy
         0wVA==
X-Gm-Message-State: AGi0PuZID/+ZDQyckoK1+fLelo9/mrx1+GAOhHGzlXIdwYOIZvga/6EQ
        mRfo8ex1kjQ5sariH2VjrDSQlw==
X-Google-Smtp-Source: APiQypICmPk2Caj99JJJTjUv1vpKU4FXLVP3n8KXyG84Gx3X0Lgu9U6NVHypIsDGjQe34+jbxd0lTg==
X-Received: by 2002:a1c:7308:: with SMTP id d8mr424161wmb.31.1586445859242;
        Thu, 09 Apr 2020 08:24:19 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:9ebe])
        by smtp.gmail.com with ESMTPSA id b85sm4281421wmb.21.2020.04.09.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:24:17 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:24:17 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409152417.GB1040020@chrisdown.name>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
 <20200409094615.GE18386@dhcp22.suse.cz>
 <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
 <20200409103400.GF18386@dhcp22.suse.cz>
 <20200409170926.182354c3@hemera.lan.sysophe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409170926.182354c3@hemera.lan.sysophe.eu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Bruno Prémont writes:
>Could it be that cache is being prevented from being reclaimed by a task
>in another cgroup?
>
>e.g.
>  cgroup/system/backup
>    first reads $files (reads each once)
>  cgroup/workload/bla
>    second&more reads $files
>
>Would $files remain associated to cgroup/system/backup and not
>reclaimed there instead of being reassigned to cgroup/workload/bla?

Yes, that's entirely possible. The first cgroup to fault in the pages is 
charged for the memory. Other cgroups may use them, but they are not accounted 
for as part of that other cgroup. They may also still be "active" as a result 
of use by another cgroup.
