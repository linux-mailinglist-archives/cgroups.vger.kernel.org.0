Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449891A3922
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2020 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDIRur (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Apr 2020 13:50:47 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51103 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIRur (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Apr 2020 13:50:47 -0400
Received: by mail-wm1-f47.google.com with SMTP id x25so666639wmc.0
        for <cgroups@vger.kernel.org>; Thu, 09 Apr 2020 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=217s5pRKcKbRlTJmbY5WRFxIFluRiLBTdWkIUP+x/Lw=;
        b=N6TkqbaMwLt4RT+I4MLjB4FBpaniFECZkDEfAw7OFhqvHoFsJ9Jo+6X1G4Mx2MQCMP
         4TuH+6KoU8y9WlMlBYZtZ8dQH93WdRjq5HaNl+qH6re/8jvcO9p8/wUEZmBEWB4ZCrhJ
         GxeMNDN1dH84JCPlhcPdBZCArChJeA2J8Yl7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=217s5pRKcKbRlTJmbY5WRFxIFluRiLBTdWkIUP+x/Lw=;
        b=oMkqL3067S+EAVGmsOCos66PHGoeD0Ph4jhm6enDS0NvgBG60dp+kMNARksP+QxoSS
         gTF5+IG6SEPNiomrtcEclob5NumvQVnfzCHYNH9u0z52IQUoIIGn+VOzTOjDh9lVTDU3
         HdsNTM2ahaJafPVst5focmRLJMTtYsz7+QPNXazQbNdKTA0P0JhW9RLeMwUqb4Wmvf78
         Rpe5eCJiMk4ICIw6hkOzA8s/DJAL8dtKpYKg1mjKv+0G41UJrTa2OcLiuz7zjrBAqRAH
         QvJe72ZdUrtDias88O5JEBD1tqUpNedlASeVt7KqEizdltLZlqabGTebRAIolTcgyBh6
         /HTA==
X-Gm-Message-State: AGi0PuYPDRUTLZ3RFJTP/KzqeRQrqwzEqM7Vw7jcvBRLfgrhsMGN7Epr
        HtuzFlSWT1lEyjMso+GtPfZd/BufVcDGDw==
X-Google-Smtp-Source: APiQypLBnoJnWXhJqHRT607ORuncyl45zOUoyN+4e1Fx8bkaewGEvI/7g+QvsntGvLoQLViWTLA4DA==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr1028279wmr.16.1586454646345;
        Thu, 09 Apr 2020 10:50:46 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:9ebe])
        by smtp.gmail.com with ESMTPSA id c4sm4720748wmb.5.2020.04.09.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 10:50:45 -0700 (PDT)
Date:   Thu, 9 Apr 2020 18:50:44 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: Memory CG and 5.1 to 5.6 uprade slows backup
Message-ID: <20200409175044.GC1040020@chrisdown.name>
References: <20200409112505.2e1fc150@hemera.lan.sysophe.eu>
 <20200409094615.GE18386@dhcp22.suse.cz>
 <20200409121733.1a5ba17c@hemera.lan.sysophe.eu>
 <20200409103400.GF18386@dhcp22.suse.cz>
 <20200409170926.182354c3@hemera.lan.sysophe.eu>
 <20200409152417.GB1040020@chrisdown.name>
 <20200409174042.2a3389ba@hemera.lan.sysophe.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409174042.2a3389ba@hemera.lan.sysophe.eu>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Bruno Prémont writes:
>On Thu, 9 Apr 2020 16:24:17 +0100 wrote:
>
>> Bruno Prémont writes:
>> >Could it be that cache is being prevented from being reclaimed by a task
>> >in another cgroup?
>> >
>> >e.g.
>> >  cgroup/system/backup
>> >    first reads $files (reads each once)
>> >  cgroup/workload/bla
>> >    second&more reads $files
>> >
>> >Would $files remain associated to cgroup/system/backup and not
>> >reclaimed there instead of being reassigned to cgroup/workload/bla?
>>
>> Yes, that's entirely possible. The first cgroup to fault in the pages is
>> charged for the memory. Other cgroups may use them, but they are not accounted
>> for as part of that other cgroup. They may also still be "active" as a result
>> of use by another cgroup.
>
>But the memory would then be 'active' in the original cgroup? which is
>not the case here I feel.

Yes, that's correct. I don't think it's the case here (since active_file is not 
that large in the affected cgroup), but it's certainly generally a possibility.
