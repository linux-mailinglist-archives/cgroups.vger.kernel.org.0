Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C00123046
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfLQP2R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:28:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37319 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLQP2R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:28:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so3638341wmf.2
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yZaScq9Meta77Nqt7I5hQ1kZiSA6MbL950o5EmEfNTs=;
        b=gJUT5JEsQl19+ZNt2Qx+/ZHcNIpwMpLwtmc3WAvlw5J9AGWaaFAnfS5qHUWnFdoq/Z
         Iu//JE+EtIRQpbdrMqEyYt1JCBMeCaj/mM58p+f9ACzA8KWvvykDijI2qRDt1Hyj90vf
         xXrj8zrMTMHBvMieWexBUEwa23r7dw16hd29k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZaScq9Meta77Nqt7I5hQ1kZiSA6MbL950o5EmEfNTs=;
        b=CZZjS4tp4Zh8zsByyFST3ZVCHOupc20ut1Zn31X6Vt2UpBar7zKdtPJDEd1xfaD9We
         0EK7iAXMAWn1pXqsHtUsOvFVf78q5UfIkpzZ2smoaNtufxClUP3fY4eW0Vy6TpsHplYp
         FsJfmrYlaHluqy4Xrqt1NKeNC4XfUEXSUMW5Ws7HRM0k0Irde5XvZPccxccXb3o6XQq0
         okVw1gTkcgOKNeUFtFbRGgE5jdkIHYR6dOOBzWfAq65sSVlX7P75Jv4QJQBWMl6ACCnY
         nHeksKct+qpLnfeVveY4z/hCaAMyWyhnnH7QVJBXoDaIPbUy3x+rxR1D/Wru6HEW+BmK
         +RzA==
X-Gm-Message-State: APjAAAUpLitp2AApvLEm5VYeKdNBDTQoEfRLr9w2Y3fuxYS1cjC6LoZN
        Ap+YeMcNr1K2MfkjCdsdxcH5KA==
X-Google-Smtp-Source: APXvYqziinXdsDWd25fUTn71tFQcAyW8kL5+5ZZ4tQ19HnR+LmDyJLSzMSxxsCE0HKdA/CJhZLV6Ig==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr6253388wmg.20.1576596495995;
        Tue, 17 Dec 2019 07:28:15 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id o194sm3477838wme.45.2019.12.17.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:28:15 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:28:14 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217152814.GB136178@chrisdown.name>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
 <20191217150921.GA136178@chrisdown.name>
 <20191217151931.GD7272@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217151931.GD7272@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>On Tue 17-12-19 15:09:21, Chris Down wrote:
>[...]
>> (Side note: I'm moderately baffled that a tightly scoped __maybe_unused is
>> considered sinister but somehow disabling -Wunused-function is on the table
>> :-))
>
>Well, I usually do not like to see __maybe_unused because that is prone
>to bit-rot and loses its usefulness. Looking into the recent git logs
>most -Wunused-function led to the code removal (which is really good
>but the compiler is likely to do that already so the overall impact is
>not that large) or more ifdefery. I do not really see many instance of
>__maybe_unused.

Hmm, but __maybe_unused is easy to find and document the reasons behind nearby, 
and then reevaluate at some later time. On the other hand, it's much *harder* 
to reevaluate which functions actually are unused in the long term if we remove 
-Wunused-function, because enabling it to find candidates will result in an 
incredibly amount of noise from those who have missed unused functions 
previously due to the lack of the warning.

Maybe Qian is right and we should just ignore such patches, but I think that 
comes with its own risks that we will alienate perfectly well intentioned new 
contributors to mm without them having any idea why we did that.
