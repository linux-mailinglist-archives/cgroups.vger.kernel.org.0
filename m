Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A893F1948A9
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCZUTE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 16:19:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44619 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCZUTE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 16:19:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id j4so8313474qkc.11;
        Thu, 26 Mar 2020 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rzV++PjycMf1C6DNb3Bvn/qTQ5TRkWt2M63e9VE4bbI=;
        b=D2TAtx8FfNkFcX/x5Nkw002dVxBLRsFTu4IS+wnPcNna/HdEd9nkWgy9PEdV/ryXF8
         irjFtYV0LC17Obpl11YhzuGa4+N49pl/Aw74ddi4HOsG7AcwArBKjooG8cYpmyV+wwG3
         yibNMAa48vwV9r3a6ZMHEhyFvTcE++PToGoR7eY/ZIYkLYDLGbMGtaAJWOMahom5CPlk
         Vv25JfW5GVTqTUL+SEfUtYSbpUIsAsEawlnnwhwDMr0Q0XOlFf7Q+n31hCeooERR5YRU
         7te2t0z/N8pjtGy7z0t+TH242ZaiAP/vaXLtsZWat51yM+LIaQ6wvz1Hj3xqTzPFhUL+
         erew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rzV++PjycMf1C6DNb3Bvn/qTQ5TRkWt2M63e9VE4bbI=;
        b=lzKrFi41CWZ6JjqUInmeUaSnvvC1DL5ranzfTROGTX4iK0pA+Y1frhq7h90U2otwFY
         PHOCqurGv0pbO2WaU+gdAMBr4cF0L49aH+YD85CESXiw3jsIrI3f2oLLIL1TL67Dy7UG
         9dvzwPfvs0ErPaqcD/QDOsO1up9xsYjzLuyXUmGdTl7q9b6Y1XO/ioihlW5VTouHV/ux
         iWcYrbSAS2ZFyD9iOAKgZcP7jw90a5wjwBy6VvWVotqg+H0E9fXIvWTonkaS7gYrYh40
         yWhV8LLW2xLNjjU7E52c7n7YIFNvMl6xeE22bvEPeibpJAz+31ZR3Y0Lqdk3Nsy8s42+
         5B9A==
X-Gm-Message-State: ANhLgQ1kJK259zF/drsPr4vQyp9zzhncwyeQAhUcFM7wW9S/Yv9HprcK
        0eYOfnkkmk/HKsvMNq09Oh8=
X-Google-Smtp-Source: ADFU+vtJtabC1yJ4OPnSe9XH97DFyXt86qeuRZ6tOIR6sMiY5i6rwl1XVXWfnzOhBmdPC3oyIg/dyw==
X-Received: by 2002:a37:d285:: with SMTP id f127mr10513039qkj.107.1585253941971;
        Thu, 26 Mar 2020 13:19:01 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id n38sm2252946qtk.64.2020.03.26.13.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:19:01 -0700 (PDT)
Date:   Thu, 26 Mar 2020 16:18:59 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Sonny Rao <sonnyrao@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Message-ID: <20200326201649.GQ162390@mtj.duckdns.org>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
 <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 26, 2020 at 01:05:04PM -0700, Sonny Rao wrote:
> I am surprised if anyone actually wants this behavior, we (Chrome OS)

The behavior is silly but consistent in that it doesn't allow empty active
cpusets and it has been like that for many many years now.

> found out about it accidentally, and then found that Android had been
> carrying a patch to fix it.  And if it were a desirable behavior then
> why isn't it an option in v2?

Nobody is saying it's a good behavior (hence the change in cgroup2) and there
are situations where changing things like this is justifiable, but, here:

* The proposed change makes the interface inconsistent and does so
  unconditionally on what is now a mostly legacy interface.

* There already is a newer version of the interface which includes the
  desired behavior.

* I forgot but as Waiman pointed out, you can even opt-in to the new
  behavior, which is more comprehensive without the inconsitencies,
  while staying on cgroup1.

Thanks.

-- 
tejun
