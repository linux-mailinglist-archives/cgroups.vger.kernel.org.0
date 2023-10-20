Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EA7D0881
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 08:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346958AbjJTGbm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Oct 2023 02:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbjJTGbl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Oct 2023 02:31:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193EACF
        for <cgroups@vger.kernel.org>; Thu, 19 Oct 2023 23:31:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9c145bb5bso82725ad.1
        for <cgroups@vger.kernel.org>; Thu, 19 Oct 2023 23:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697783499; x=1698388299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qeeYz5V48ireqFEi+ywjuz8ashXtpLODjwuWX4lfJE=;
        b=03J+BQwkg76Nw8fMdnvZxph3okcpcJ8vnKpmjMp6mHuplAUCGGdCoXYkW39/W3NCqU
         KIvpooeuFhmLB3YMuayuU2r6HMz0W9CjFCTGLJmjyaWyjt/mr/yBzA/OA86cSg1qKpHw
         r6vZMUwaa+oQYsrNQ0qpMuJmwx636lBcG3c2a2VKi2ag5agW5FzfjejyOOFtxD/Yjb4a
         Ph61fXnqNVfnUnjVQx5B94BNibctOFmVkE1Uj08LPVdUYAAYgOUOZgdXnfm3Y/AyII1p
         Av07J+vRsmXcLirwghmeVGAVMo7V7MtFcEH5KWGajRqcKQcfjeJ7L/8PEZ/k625xTNjk
         zQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697783499; x=1698388299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qeeYz5V48ireqFEi+ywjuz8ashXtpLODjwuWX4lfJE=;
        b=rW0jU9FLUAM7XwCQgNHjd7FYvDKksL1n8+Yl8/dlpSSI4aj7QhcmY6xv1WvgzS9MXz
         /FdKRCSAXmsxvLJFyONhqpxS4n4qhRGExcEUGSa2URDxSvm7oE3oYY6nG5jwv92iN0dY
         Fw3d1z03mF9xLcTjrpbmX2AXQibbw3Aoe5njF6zUSTgcG0Z5b1LFGUIgnhdEZOMMGwWd
         Nsdq18nV225rUGt603jxJsR0pEok/OgaNycY5gh1WKayIu3ReWlmVZFvt9qucF9WIAEk
         dlRHQ+T3i7O+VwvCS/tkQVfhNIWjGWq6qU3EMHA45l3AgYhoIC0NMdOCmQiWASK2OFQ5
         1yWA==
X-Gm-Message-State: AOJu0YyuVCoNa79XlYtf0n/ep9x2nPEd1XMzYo9MqpXk8x6mZfDphQ0r
        WioFnYHT0yRj+5Vk9IuAeJez1nlF4h19VsjJYZvv6A==
X-Google-Smtp-Source: AGHT+IEV87PSEZnNQs7z3oFbyuV1txN/MwORzwAyr5f2vLqQcxrpEiA3daUgZkoV+qaBa67byOF4TwXuDZEG8DKfJoE=
X-Received: by 2002:a17:903:8c4:b0:1c9:e53b:4099 with SMTP id
 lk4-20020a17090308c400b001c9e53b4099mr147617plb.8.1697783495364; Thu, 19 Oct
 2023 23:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231019225346.1822282-1-roman.gushchin@linux.dev> <20231019225346.1822282-7-roman.gushchin@linux.dev>
In-Reply-To: <20231019225346.1822282-7-roman.gushchin@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Oct 2023 23:31:23 -0700
Message-ID: <CALvZod4EWoH7HGMWU+f6svP9gjDUh==GUS3GuD7CxhnB+mq9wA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: kmem: reimplement get_obj_cgroup_from_current()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 19, 2023 at 3:54=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Reimplement get_obj_cgroup_from_current() using current_obj_cgroup().
> get_obj_cgroup_from_current() and current_obj_cgroup() share 80% of
> the code, so the new implementation is almost trivial.
>
> get_obj_cgroup_from_current() is a convenient function used by the
> bpf subsystem, so there is no reason to get rid of it completely.
>
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeelb@google.com>
