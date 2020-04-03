Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0619D985
	for <lists+cgroups@lfdr.de>; Fri,  3 Apr 2020 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbgDCOyW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Apr 2020 10:54:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45978 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOyV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Apr 2020 10:54:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id o18so5378774qko.12;
        Fri, 03 Apr 2020 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qyus9wEurAIsnv0KktXUQAPVSjugd3/P/58Fl3RicEU=;
        b=AsMjO4gFG/KXUlzlax7BKYVPEzhqXKQC1Xgj+6ktBQX8c79pf9D9fDvjN0PhCoBALB
         NYUDhQGz+MFxBY/tKwUkORWhVJPah3s36fFIe1usQXybxHqknrWgb5LGQopO7mDMwt9s
         13PIz1GKaNUteJUiZr2asCr+CwNxf/FALTr+MP6W0AcE3pvVmgltqKj+MVNIP6QzaUzF
         vyBN0pHykga9tV1YgB6OqZy9QlylEz2/psehTECYZtoRFA+proI997MDHcKhy3Su8HJz
         dv7wL63P4+DjSgV/KuLlWlKFoiQ+EEZI3keIoEGHiKIoEcRVx9H8q8cDQWx4re3y3U38
         +9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Qyus9wEurAIsnv0KktXUQAPVSjugd3/P/58Fl3RicEU=;
        b=LnMjSrSAL3wX/KDmCDXFXVm3Q9VkcJoGrGPIp5CcIJUq95WZHc/cJHChLn22KpKCdW
         pWc3bG1Pc1reH1TFoH73eXKatT65vGkG08SOCk5r1c+TdDo23kFZiCOhKUop4cZnmxC/
         lrELl1pBQpJ9wjRLBZhPMKZIsu6pPpHSYyBTNsnepclC9aIaL7KC0Hb3b23quXq3paw+
         uwH8QlCswKzVPr+ZCvSeDmENymL5oTBEbPyJ9rfqVv/EVNVWEO48nRzrfO+IvqyFiwXF
         7tjLSkcDFg347Sy41EhiNGSsqarFV1fIkVjAYM0R5NUAFVVqrURcXBiYOd6ohVFri8nJ
         V1/Q==
X-Gm-Message-State: AGi0PuahD9iKfCKT0qToC9xpvItmORiNXkjMe4LzLfKKdVYzDTNxSfWv
        EWm/cLlzBfxEs5SmRTAct8Y=
X-Google-Smtp-Source: APiQypJEdBPfmXOuzJ8JYh/Jyhg63+9foiTxBStOFtcR0yFpV717o79f78RVq/NBTzZk1bEtOiq+kw==
X-Received: by 2002:a37:b981:: with SMTP id j123mr9347140qkf.32.1585925660957;
        Fri, 03 Apr 2020 07:54:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::842b])
        by smtp.gmail.com with ESMTPSA id 79sm6421528qkg.38.2020.04.03.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:54:20 -0700 (PDT)
Date:   Fri, 3 Apr 2020 10:54:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200403145418.GB162390@mtj.duckdns.org>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
 <6AD62381-394F-4742-816B-12DE67DE9788@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6AD62381-394F-4742-816B-12DE67DE9788@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 01, 2020 at 10:00:31PM -0400, Qian Cai wrote:
> 
> 
> > On Mar 25, 2020, at 3:19 PM, Tejun Heo <tj@kernel.org> wrote:
> > 
> > On Wed, Mar 25, 2020 at 03:16:56PM -0400, Qian Cai wrote:
> >> The linux-next commit a49e4629b5ed (“cpuset: Make cpuset hotplug synchronous”)
> >> introduced real deadlocks with CPU hotplug as showed in the lockdep splat, since it is
> >> now making a relation from cpu_hotplug_lock —> cgroup_mutex.
> > 
> > Prateek, can you please take a look? Given that the merge window is just around
> > the corner, we might have to revert and retry later if it can't be resolved
> > quickly.
> 
> Tejun, can you back off this commit now given it seems nobody is trying to rescue it?

Yeah, gonna revert it before sending out the pull request.

Thanks.

-- 
tejun
