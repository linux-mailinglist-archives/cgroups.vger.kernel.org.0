Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64B78458A
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjHVPar (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 11:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjHVPaq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 11:30:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69361CD1
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 08:30:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9338e4695so72064801fa.2
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692718242; x=1693323042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jLe3aS6oHv7LXqfot3AlJx+jHhWMRNhwylusvC3Hno=;
        b=1nNMUj+JgJ/msq8cZiBCa8v/TbP0d9ORcQHmlu9M6RZjcKQX2uBVnok+in04BF0Vm5
         7+i96DocFBoQbs6OYoLWk1N4vsYFad0F6MfUJIG6SBHbJn0sQGeFtVZZ4a2HyReq1YRf
         d1TeFz/A+7H3zimfpnsaJZuOoO2shESI+2b9Gme610irXIm45tk9VHkHUKTzgBhc6t1K
         pyXfs8KOOM4WsfihKZLR7DK60sB7CDhIg+OqQtx2aglkouLVsfFCETc9lv81Od8a3kCf
         58bhwp9+lhlyWY/vmP6/SneKCtCSGaja1ZfZKeEXYeicRuuo9GGCGgUmY/1IWpRVBMaj
         LIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718242; x=1693323042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jLe3aS6oHv7LXqfot3AlJx+jHhWMRNhwylusvC3Hno=;
        b=DTboOlcZqZ045rTMPdO3MyNnNZGiu7nD4jWkgCWhY0MKoxcdf0pnLgO+0A98ClGP6U
         fMp2ME+ZAOwvlFoaIonBTkOB4SKw0BsvP1sHZTNKe+ITW46qPXYR/t4XXxBC8kQxls22
         eCLYJsdeJBS5RoENNjIiW55UuUrxwZ/BsNLP9UevCfUxOtHuhsqTM7dl0eS/vHm6bqhC
         3ykZxupOO4Wzk35NqPW0Hy+tTDe6pkFDfIApEhCsk1RKm6jbKE91jRfa/d98hQYw4SKL
         tqMdRX1hNa72Y4xEKUAQmGxiayQG6hy1H+wB863mV3Q6xgJn4i+t8zS6A9anCniM44vj
         Virw==
X-Gm-Message-State: AOJu0Yw1yjcD1DUQbD9M4WbSagWsWNywMmdvBa9q0UmPExoxe6etZtGy
        5v9Ft2zRC4lfCivF0C+DzmurX3C+UohnwPE0xhHGfA==
X-Google-Smtp-Source: AGHT+IHj5NEzUxDIG8nZNuwvZFRAKokOiiGQkNLlSwSEoa9qnMaznGTV9FDbXoxI5OM5wbSxZjgLunlmQRlGB+LZ6lE=
X-Received: by 2002:a2e:8891:0:b0:2b9:f3b4:6808 with SMTP id
 k17-20020a2e8891000000b002b9f3b46808mr7836633lji.29.1692718242268; Tue, 22
 Aug 2023 08:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com> <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
In-Reply-To: <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 22 Aug 2023 08:30:05 -0700
Message-ID: <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008ab2d0060384ad3e"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--0000000000008ab2d0060384ad3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 2:06=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 21-08-23 20:54:58, Yosry Ahmed wrote:
> > Unified flushing allows for great concurrency for paths that attempt to
> > flush the stats, at the expense of potential staleness and a single
> > flusher paying the extra cost of flushing the full tree.
> >
> > This tradeoff makes sense for in-kernel flushers that may observe high
> > concurrency (e.g. reclaim, refault). For userspace readers, stale stats
> > may be unexpected and problematic, especially when such stats are used
> > for critical paths such as userspace OOM handling. Additionally, a
> > userspace reader will occasionally pay the cost of flushing the entire
> > hierarchy, which also causes problems in some cases [1].
> >
> > Opt userspace reads out of unified flushing. This makes the cost of
> > reading the stats more predictable (proportional to the size of the
> > subtree), as well as the freshness of the stats. Since userspace reader=
s
> > are not expected to have similar concurrency to in-kernel flushers,
> > serializing them among themselves and among in-kernel flushers should b=
e
> > okay.
> >
> > This was tested on a machine with 256 cpus by running a synthetic test
> > The script that creates 50 top-level cgroups, each with 5 children (250
> > leaf cgroups). Each leaf cgroup has 10 processes running that allocate
> > memory beyond the cgroup limit, invoking reclaim (which is an in-kernel
> > unified flusher). Concurrently, one thread is spawned per-cgroup to rea=
d
> > the stats every second (including root, top-level, and leaf cgroups --
> > so total 251 threads). No regressions were observed in the total runnin=
g
> > time; which means that non-unified userspace readers are not slowing
> > down in-kernel unified flushers:
>
> I have to admit I am rather confused by cgroup_rstat_flush (and
> cgroup_rstat_flush_locked). The former says it can block but the later
> doesn't ever block and even if it drops the cgroup_rstat_lock it merely
> cond_rescheds or busy loops. How much of a contention and yielding can
> you see with this patch? What is the worst case? How bad a random user
> can make the situation by going crazy and trying to flush from many
> different contexts?

Userspace readers (or more generically non-unified flushers) can all
collectively only block a single unified flusher at most.
Specifically, one userspace reader goes to flush and holds
cgroup_rstat_lock, meanwhile an in-kernel flusher (e.g. reclaim) goes
and tries to flush, and spins on cgroup_rstat_lock. Other in-kernel
(unified) flushers will just see another unified flusher in progress
and skip. So userspace can only block a single in-kernel reclaimer.
Not that it's not really that bad because:
(a) As you note, cgroup_rstat_flush() does not really "block", it's
cpu-bound. Even when it cond_resched()'s, it yields the lock first. So
it can't really hold anyone hostage for long.
(b) I assume a random user can only read their own stats, which should
be a relatively small subtree, quick to flush. I am assuming a random
user cannot read root's memory.stat (which is most expensive).
(c) Excessive flushing doesn't really build up because there will be
nothing to flush and the lock will be released very shortly after it's
held.

So to answer your question, I don't think a random user can really
affect the system in a significant way by constantly flushing. In
fact, in the test script (which I am now attaching, in case you're
interested), there are hundreds of threads that are reading stats of
different cgroups every 1s, and I don't see any negative effects on
in-kernel flushers in this case (reclaimers).

> --
> Michal Hocko
> SUSE Labs

--0000000000008ab2d0060384ad3e
Content-Type: text/x-sh; charset="US-ASCII"; name="stress.sh"
Content-Disposition: attachment; filename="stress.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_llmgovtf0>
X-Attachment-Id: f_llmgovtf0

IyEvYmluL2Jhc2gKCk5SX0wxX0NHUk9VUFM9NTAKTlJfTDJfQ0dST1VQU19QRVJfTDE9NQpOUl9M
Ml9DR1JPVVBTPSQoKCBOUl9MMV9DR1JPVVBTICogTlJfTDJfQ0dST1VQU19QRVJfTDEgKSkKTlJf
V09SS0VSU19QRVJfQ0dST1VQPTEwCldPUktFUl9NQj0xMApOUl9UT1RBTF9XT1JLRVJTPSQoKCBO
Ul9XT1JLRVJTX1BFUl9DR1JPVVAgKiAoMSArIE5SX0wxX0NHUk9VUFMgKyBOUl9MMl9DR1JPVVBT
KSApKQpMMV9DR1JPVVBfTElNSVRfTUI9JCgoIE5SX0wyX0NHUk9VUFNfUEVSX0wxICogTlJfV09S
S0VSU19QRVJfQ0dST1VQICogV09SS0VSX01CIC8gNCApKQpUT1RBTF9NQj0kKCggTlJfVE9UQUxf
V09SS0VSUyAqIFdPUktFUl9NQiApKQpUTVBGUz0kKG1rdGVtcCAtZCkKUk9PVD0iL3N5cy9mcy9j
Z3JvdXAvIgpBRE1JTj0iL3N5cy9mcy9jZ3JvdXAvYWRtaW4iClpSQU1fREVWPSIvbW50L2RldnRt
cGZzL3pyYW0wIgoKY2xlYW51cF9jZ3JvdXAoKSB7CiAgbG9jYWwgLXIgY2c9JDEKICBsb2NhbCAt
ciBwcm9jcz0kKGNhdCAkY2cvY2dyb3VwLnByb2NzKQogIGlmIFtbIC1uICRwcm9jcyBdXTsgdGhl
bgogICAga2lsbCAtS0lMTCAkcHJvY3MKICAgIHdhaXQgJHByb2NzIDI+L2Rldi9udWxsCiAgZmkK
ICB3aGlsZSBbWyAtbiAkKGNhdCAkY2cvY2dyb3VwLnByb2NzKSBdXTsgZG8KICAgIHNsZWVwIDAu
MQogIGRvbmUKICBybWRpciAkY2cKfQoKY2xlYW51cCgpIHsKICBmb3IgaSBpbiAkKHNlcSAkTlJf
TDFfQ0dST1VQUyk7IGRvCiAgICBsMT0iJFJPT1QvcGFyZW50JGkiCiAgICBmb3IgaiBpbiAkKHNl
cSAkTlJfTDJfQ0dST1VQU19QRVJfTDEpOyBkbwogICAgICBsMj0iJGwxL2NoaWxkJGoiCiAgICAg
IGNsZWFudXBfY2dyb3VwICRsMgogICAgZG9uZQogICAgY2xlYW51cF9jZ3JvdXAgJGwxCiAgZG9u
ZQoKICBjbGVhbnVwX2Nncm91cCAkQURNSU4KCiAgdW1vdW50ICRUTVBGUwogIHJtIC1yZiAkVE1Q
RlMKCiAgc3dhcG9mZiAkWlJBTV9ERVYKICBlY2hvIDEgPiAiL3N5cy9ibG9jay96cmFtMC9yZXNl
dCIKfQp0cmFwIGNsZWFudXAgSU5UIFFVSVQgRVhJVAoKcnVuX3N0YXRzX3JlYWRlcigpIHsKICBs
b2NhbCAtciBjZ19ydW49JDEKICBsb2NhbCAtciBjZ19yZWFkPSQyCgogICMgcmVhZCB0aGUgc3Rh
dHMgZXZlcnkgc2Vjb25kIHVudGlsIHdvcmtlcnMgYXJlIGRvbmUKICBlY2hvIDAgPiAiJGNnX3J1
bi9jZ3JvdXAucHJvY3MiCiAgd2hpbGUgW1sgJChscyAkVE1QRlMpIF1dOyBkbwogICAgY2F0ICIk
Y2dfcmVhZC9tZW1vcnkuc3RhdCIgPiAvZGV2L251bGwKICAgIHNsZWVwIDEKICBkb25lCn0KCnJ1
bl93b3JrZXIoKSB7CiAgbG9jYWwgLXIgY2c9JDEKICBsb2NhbCAtciBmPSQyCgogIGVjaG8gMCA+
ICIkY2cvY2dyb3VwLnByb2NzIgogIHJtIC1yZiAiJGYiCiAgZGQgaWY9L2Rldi96ZXJvIG9mPSIk
ZiIgYnM9MU0gY291bnQ9JFdPUktFUl9NQiBzdGF0dXM9bm9uZQogIGNhdCAiJGYiID4gL2Rldi9u
dWxsCiAgcm0gIiRmIgp9CgojIFNldHVwIHpyYW0KZWNobyAkKChUT1RBTF9NQiA8PCAyMCkpID4g
Ii9zeXMvYmxvY2svenJhbTAvZGlza3NpemUiCm1rc3dhcCAkWlJBTV9ERVYKc3dhcG9uICRaUkFN
X0RFVgplY2hvICJTZXR1cCB6cmFtIGRvbmUiCgojIE1vdW50IHRtcGZzCm1vdW50IC10IHRtcGZz
IG5vbmUgJFRNUEZTCgojIENyZWF0ZSBhZG1pbiBjZ3JvdXAKbWtkaXIgJEFETUlOCgojIENyZWF0
ZSB3b3JrZXIgY2dyb3Vwcywgc2V0IGxpbWl0cwplY2hvICIrbWVtb3J5IiA+ICIkUk9PVC9jZ3Jv
dXAuc3VidHJlZV9jb250cm9sIgpmb3IgaSBpbiAkKHNlcSAkTlJfTDFfQ0dST1VQUyk7IGRvCiAg
bDE9IiRST09UL3BhcmVudCRpIgogIG1rZGlyICRsMQogIGVjaG8gIittZW1vcnkiID4gIiRsMS9j
Z3JvdXAuc3VidHJlZV9jb250cm9sIgogIGZvciBqIGluICQoc2VxICROUl9MMl9DR1JPVVBTX1BF
Ul9MMSk7IGRvCiAgICBsMj0iJGwxL2NoaWxkJGoiCiAgICBta2RpciAkbDIKICBkb25lCiAgZWNo
byAkKCggTDFfQ0dST1VQX0xJTUlUX01CIDw8IDIwKSkgPiAiJGwxL21lbW9yeS5tYXgiCmRvbmUK
ZWNobyAiU2V0dXAgJE5SX0wxX0NHUk9VUFMgTDEgY2dyb3VwcyB3aXRoIGxpbWl0ICR7TDFfQ0dS
T1VQX0xJTUlUX01CfU0gZG9uZSIKZWNobyAiRWFjaCBMMSBjZ3JvdXAgaGFzICROUl9MMl9DR1JP
VVBTX1BFUl9MMSBMMiBjaGlsZHJlbiIKCiMgU3RhcnQgd29ya2VycyB0byBhbGxvY2F0ZSB0bXBm
cyBtZW1vcnkKZm9yIGkgaW4gJChzZXEgJE5SX0wxX0NHUk9VUFMpOyBkbwogIGwxPSIkUk9PVC9w
YXJlbnQkaSIKICBmb3IgaiBpbiAkKHNlcSAkTlJfTDJfQ0dST1VQU19QRVJfTDEpOyBkbwogICAg
bDI9IiRsMS9jaGlsZCRqIgogICAgZm9yIGsgaW4gJChzZXEgJE5SX1dPUktFUlNfUEVSX0NHUk9V
UCk7IGRvCiAgICAgIChydW5fd29ya2VyICIkbDIiICIkVE1QRlMvJGktJGotJGsiKSYKICAgIGRv
bmUKICBkb25lCmRvbmUKCiMgU3RhcnQgc3RhdCByZWFkZXJzCihydW5fc3RhdHNfcmVhZGVyICIk
QURNSU4iICIkUk9PVCIpJgpmb3IgaSBpbiAkKHNlcSAkTlJfTDFfQ0dST1VQUyk7IGRvCiAgbDE9
IiRST09UL3BhcmVudCRpIgogIChydW5fc3RhdHNfcmVhZGVyICIkQURNSU4iICIkbDEiKSYKICBm
b3IgaiBpbiAkKHNlcSAkTlJfTDJfQ0dST1VQU19QRVJfTDEpOyBkbwogICAgbDI9IiRsMS9jaGls
ZCRqIgogICAgIyBSYW4gc3RhdCByZWFkZXJzIGluIHRoZSBhZG1pbiBjZ3JvdXAgYXMgd2VsbCBh
cyB0aGUgY2dyb3VwIGl0c2VsZgogICAgKHJ1bl9zdGF0c19yZWFkZXIgIiRBRE1JTiIgIiRsMiIp
JgogICAgKHJ1bl9zdGF0c19yZWFkZXIgIiRsMiIgIiRsMiIpJgogIGRvbmUKZG9uZQoKIyBXYWl0
IGZvciB3b3JrZXJzCmVjaG8gIlJhbiAkTlJfV09SS0VSU19QRVJfQ0dST1VQIHdvcmtlcnMgcGVy
IEwyIGNncm91cCwgZWFjaCBhbGxvY2F0aW5nICR7V09SS0VSX01CfU0sIHdhaXRpbmcuLiIKd2Fp
dAoK
--0000000000008ab2d0060384ad3e--
